/* Program that reads in a text file of a postfix expression
   and outputs the value */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct Stack{
    double data;
    struct Stack *next;
};

// push to double stack
void push(struct Stack **top,double data){
    struct Stack *tmp;
    tmp = malloc(sizeof(struct Stack));

    tmp->data = data;
    tmp->next = *top;

    *top = tmp;
}

// pop item from top of stack
double pop(struct Stack **head){
    double data;
    struct Stack *tmp;

    tmp = *head;
    *head = tmp->next;
    data = tmp->data;
    free(tmp);
    return data;
}

// char linked list
struct CharStack{
    char data;
    struct CharStack *next;
};

// push item to top of stack
void pushChar(struct CharStack **head,char data){
    struct CharStack *tmp;
    tmp = malloc(sizeof(struct CharStack));

    tmp->data = data;
    tmp->next= *head;

    *head = tmp;
}

// pop item from top of char stack
char popChar(struct CharStack **head){
    char data;
    struct CharStack *tmp;

    tmp = *head;
    *head = tmp->next;
    data = tmp->data;
    free(tmp);
    return data;
}

// remove an item by index
char popCharByIndex(struct CharStack ** head, int n) {
    int i = 0;
    char value = '\0';
    struct CharStack * current = *head;
    struct CharStack * tmp = NULL;

    if (n == 0) {
        return popChar(head);
    }

    // go to index - 1
    for (i = 0; i < n-1; i++) {
        if (current->next == NULL) {
            return value;
        }
        current = current->next;
    }

    // link node of index - 1 to index + 1
    tmp = current->next;
    value = tmp->data;
    current->next = tmp->next;
    free(tmp);

    return value;

}

//Returns the size of an array from its pointer
int get_pointer_size (char * array) {
    char * count;
    for (count = array; *count != '\0'; count++);
    return count - array;
}

/*
  returns a pointer to the expression
  reads the first expression from expression.txt
  returns null on error
*/
char * read_expression_from_file(){
  FILE *file;
  char *line = NULL;
  size_t len = 0;
  char read;

  file=fopen("expression.txt", "r");
  if(file == NULL){
    printf("Error when trying to open file\n");
    return '\0';
  }

  read = getline(&line, &len, file);
  return line;
}

/*
  Gets an infix expression and converts it to postfix notation
*/
char * get_postfix_from_infix(char *infix){
  //get size of infix expression
  int exprSize = get_pointer_size(infix);
  struct CharStack *stack = NULL;
  char *postfix = malloc(4 * exprSize);
  int i = 0;
  int index = 0;

  // loop through every element from infix expression
  for(int i = 0; i < exprSize; i++){
    // char is a number, add to output string
    if((infix[i] >= '0' && infix[i] <= '9') || infix[i] == ' '){
      postfix[index] = infix[i];
      index++;

    // char is a (, push to stack
    } else if (infix[i] == '('){
      pushChar(&stack, '(');

    // char is an operator
    } else if (infix[i] == '^' || infix[i] == '/' || infix[i] == 'X'
        || infix[i] == '+' || infix[i] == '-') {
          int thereIsAnOperatorInStack = 1;

          // look for operators with higher priority than the current one
          while(thereIsAnOperatorInStack == 1){
            int operatorIndex = 0;
            struct CharStack * loopStack = stack;

            // loop through stack
            while (loopStack != NULL && thereIsAnOperatorInStack == 1) {
              char val = loopStack->data;

              // find operators
                if(val == '^' || val == '/' || val == 'X'
                  || val == '+' || val == '-'){
                  switch(infix[i]){
                    case '+':
                    case '-':
                    // current char is lowest priority, look for anything higher
                      if(val != '-' && val != '+'){
                        postfix[index++] = val;
                        popCharByIndex(&stack, operatorIndex);
                      } else {
                        thereIsAnOperatorInStack = 0;
                      }
                      break;
                    case 'X':
                    case '/':
                    // current char is of 2nd priority, look for '^'
                    // as it is the only operator with a higher priority
                      if(val == '^'){
                        postfix[index++] = val;
                        popCharByIndex(&stack, operatorIndex);
                      } else {
                        thereIsAnOperatorInStack = 0;
                      }
                      break;
                  }
                } else {
                  loopStack = loopStack->next;
                  operatorIndex++;
                }
            }
            if(loopStack == NULL){
              thereIsAnOperatorInStack = 0;
            }
          }
          pushChar(&stack, infix[i]);
    } else if (infix[i] == ')'){
      int popStack = 1;
      while (popStack == 1){
        char val = popChar(&stack);
        if(val == '('){
          popStack = 0;
        } else {
          postfix[index++] = val;
        }
      }
    }
  }

  //pop remaining elements from stack and add to output string
  while(stack != NULL){
    postfix[index++] = ' ';
    postfix[index++] = stack->data;
    stack = stack->next;
  }
  postfix[index++] = '\0';
  // free unused memory
  for(int i = index; i  < sizeof(postfix); i++){
    free(&postfix[i]);
  }
  return postfix;
}

/*
  Gets a postfix expression and computes the answer
*/
double calculate_postfix_expression(char *expr){
  // var & stack declaration
  struct Stack *s = NULL;
  double a;
  double b;
  int i = 0;
  int tmpIndex;
  double tmpValue;

  // loop through every element from postfix expression string
  while(expr[i] != '\0'){
    // push numbers to stack
    if(expr[i] >= '0' && expr[i] <= '9'){
        tmpValue = expr[i] - '0';
        tmpIndex = i;
        int endOfLoop = 1;

        // get full number by checking if next number is a number or not
        // if next char is a number, append it to current number
        while(endOfLoop == 1){
          tmpIndex++;
          if(expr[tmpIndex] == ' ' || expr[tmpIndex] == '\n'){
            endOfLoop = 0;
            if(tmpIndex == i + 1) tmpIndex--;
          } else {
            tmpValue *= 10;
            tmpValue += expr[tmpIndex] - '0';
          }
        }
        i = tmpIndex;
        push(&s, tmpValue);
    } else {
      // compute expression from given operator
      // pops 2 items from stack and applies the operator to them
      // push result to stack
      switch (expr[i]) {
        case '+':
          a = pop(&s);
          b = pop(&s);
          push(&s, a + b);
          break;
        case '-':
          a = pop(&s);
          b = pop(&s);
          push(&s, b - a);
          break;
        case '*':
        case 'X':
        case 'x':
          a= pop(&s);
          b = pop(&s);
          push(&s, a * b);
          break;
        case '/':
        case '%':
          a = pop(&s);
          b = pop(&s);
          push(&s, b / a);
          break;
        case '^':
          a = pop(&s);
          b = pop(&s);
          push(&s, pow(b, a));
          break;
        case ' ':
        case '\n':
          break;
        default:
          printf("Error: char not supported entered: %c", expr[i]);
      }
    }
    i++;
  }
  //return final result
  return pop(&s);
}

/*
read in an expression in infix notation
convert it to postfix notation
calculate the result of the Expression
show the result in console
*/
int main()
{
  char *infix;
  char *postfix;
  infix = read_expression_from_file();
  if(infix == NULL){
    return -1;
  }
  printf("infix expr is %s", infix);
  postfix = get_postfix_from_infix(infix);
  free(infix);
  printf("postfix expre is %s\n", postfix);
  double value = calculate_postfix_expression(postfix);
  free(postfix);
  printf("result is %f!\n", value);
  fflush(stdout);
  return 0;
}
