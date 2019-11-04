// do NOT modify this file

#include "global.h"

char* strappend(char* dest, const char* source) {
    if (dest == NULL) {
        dest = (char*)malloc((strlen(source) + 1) * sizeof(char));
        strcpy(dest, source);
    } else {
        int dest_len = strlen(dest);
        dest = realloc(dest, (dest_len + strlen(source) + 1) * sizeof(char));
        strcat(dest, source);
    }
    return dest;
}

static char* HTML_BEGIN_TEXT =
    "<html>\n<head>\n\t<meta charset=\"utf-8\">\n"
    "\t<title>Mini-Markdown Parser - Result Page</title>\n</head>\n"
    "<body>\n";
static char* HTML_END_TEXT = "</body>\n</html>";

static char* h_beg[] = {" ", "<h1>", "<h2>", "<h3>", "<h4>", "<h5>", "<h6>"};
static char* h_end[] = {" ", "</h1>", "</h2>", "</h3>", "</h4>", "</h5>", "</h6>"};

Html_Doc* new_html_doc() {
    Html_Doc* doc = (Html_Doc*)malloc(sizeof(Html_Doc));
    doc->body = malloc(1);
    doc->body[0] = '\0';
    doc->begin_text = HTML_BEGIN_TEXT;
    doc->end_text = HTML_END_TEXT;
    return doc;
}

void del_html_doc(Html_Doc* htmldoc) {
    if (htmldoc) {
        free(htmldoc->body);
        free(htmldoc);
    }
}

void add_element(Html_Doc *htmldoc, const char* text){
    htmldoc->body = strappend(htmldoc->body, text);
    htmldoc->body = strappend(htmldoc->body, "\n");
}

void add_linebreak(Html_Doc *htmldoc){
    htmldoc->body = strappend(htmldoc->body, "<br>\n");
}

void output_result(Html_Doc* htmldoc) {
    printf("%s\n", htmldoc->begin_text);
    printf("%s\n", htmldoc->body);
    printf("%s\n", htmldoc->end_text);
}

char* generate_header(int level, const char* text) {
    char* str = NULL;
    str = strappend(str, h_beg[level]);
    str = strappend(str, text);
    str = strappend(str, h_end[level]);
    return str;
}

char* generate_image(const char* image_name, const char* image_url, int width, int height) {
    //e.g., <img src="img_url.jpg" alt="img_name" width="500" height="600">
    //convert int to char* array
    char width_str[100];
    char height_str[100];
    sprintf(width_str, "%d", width);
    sprintf(height_str, "%d", height);

    char* str = NULL;
    str = strappend(str, "<img src=\"");
    str = strappend(str, image_url);
    str = strappend(str, "\" alt=\"");
    str = strappend(str, image_name);
    str = strappend(str, "\" width=\"");
    str = strappend(str, width_str);
    str = strappend(str, "\" height=\"");
    str = strappend(str, height_str);
    str = strappend(str, "\">");
    return str;
}

char* generate_bold(const char* text) {
    char* str = NULL;
    str = strappend(str, "<b>");
    str = strappend(str, text);
    str = strappend(str, "</b>");
    return str;
}
char* generate_italic(const char* text) {
    char* str = NULL;
    str = strappend(str, "<i>");
    str = strappend(str, text);
    str = strappend(str, "</i>");
    return str;
}
char* generate_paragraph(const char* text) {
    char* str = NULL;
    str = strappend(str, "<p>");
    str = strappend(str, text);
    str = strappend(str, "</p>");
    return str;
}
