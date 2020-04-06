# to use : python qlearning.py 1 fit 0.8 (here 1 is the n value, second input is fit or unfit, 0.8 is the lanbda discount value g)
import sys
from multiprocessing import Process

class CustomErrorHandling(Exception):
    pass
class IllegalGValueError(CustomErrorHandling):
   '''Raised when the input value of G is not more than 0 and less than 1'''
   pass
class IllegalSValueError(CustomErrorHandling):
   '''Raised when the input value of s is not one of the valid 3 states'''
   pass

def show_error_message(msg):
    print(msg)
    print('Use this script as such : python qlearning.py <n value> <s value> <g value>')
    return

# Used as such: MATRIX[a][s][s']['probability' or 'reward']
MATRIX = {
	'exercise': {
		'fit': {
            'fit': {
                'probability': 0.9*0.99,
			    'reward': 8,
            },
			'unfit': {
                'probability': 0.9*0.01,
			    'reward': 8,
            },
			'dead': {
                'probability': 0.1,
			    'reward': 0,
            },
		},
        'unfit': {
            'fit': {
                'probability': 0.9*0.2,
			    'reward': 0,
            },
			'unfit': {
                'probability': 0.9*0.8,
			    'reward': 0,
            },
			'dead': {
                'probability': 0.1,
			    'reward': 0,
            },
		},
        'dead': {
            'fit': {
                'probability': 0,
			    'reward': 0,
            },
			'unfit': {
                'probability': 0,
			    'reward': 0,
            },
			'dead': {
                'probability': 1,
			    'reward': 0,
            },
		},
	},
	'relax': {
        'fit': {
            'fit': {
                'probability': 0.99*0.7,
			    'reward': 10,
            },
			'unfit': {
                'probability': 0.99*0.3,
			    'reward': 10,
            },
			'dead': {
                'probability': 0.01,
			    'reward': 0,
            },
		},
        'unfit': {
            'fit': {
                'probability': 0.99*0,
			    'reward': 5,
            },
			'unfit': {
                'probability': 0.99*1,
			    'reward': 5,
            },
			'dead': {
                'probability': 1,
			    'reward': 0,
            },
		},
        'dead': {
            'fit': {
                'probability': 0,
			    'reward': 0,
            },
			'unfit': {
                'probability': 0,
			    'reward': 0,
            },
			'dead': {
                'probability': 1,
			    'reward': 0,
            },
		},
	}
}

def p(s, a, newS):
	return MATRIX[a][s][newS]['probability']

def r(s, a, newS):
	return MATRIX[a][s][newS]['reward']

def v(n, s):
	return max(q(n, s, 'exercise'), q(n, s, 'relax'))

def q(n, s, a):
	if n == 0:
		return (
			p(s, a, 'fit')*r(s, a, 'fit') +
			p(s, a, 'unfit')*r(s, a, 'unfit') + 
            p(s, a, 'dead')*r(s, a, 'dead')
		)
	return (
		q(0, s, a) +
		(g*(p(s, a, 'fit')*v(n-1, 'fit') +
		p(s, a, 'unfit')*v(n-1, 'unfit') +
		p(s, a, 'dead')*v(n-1, 'dead')))
	)
validStates = ['fit', 'unfit', 'dead']
try:
    n = sys.argv[1]
    s = sys.argv[2]
    g = sys.argv[3]
    n = int(n)
    
    g = float(g)
    if g <= 0 or g >= 1:
        raise IllegalGValueError
    if s not in validStates:
        raise IllegalSValueError
except IndexError:
    show_error_message('This script requires exactly 3 arguments.') 
    exit(1)
except ValueError:
	show_error_message('Tried to convert invalid input to a number type!')
	exit(1)
except IllegalGValueError:
	show_error_message('The input for g: {} must be more than 0 and less than 1!'.format(g))
	exit(1)
except IllegalSValueError:
	show_error_message('The input for s: {} must be one of the following: fit unfit dead'.format(g))
	exit(1)

# Function to compute q, defined in order to compute exercise and relax values concurrently
def compute_q(n, s, exOrRelax):
    value = q(n, s, exOrRelax)
    print 'qn={0}({1}, {2}):'.format(n, s, exOrRelax), value

print 'Note: The order of the outputs printed varies based on which thread finished first!'
print 'Computing with input values...'
print 'n:', n 
print 'Lambda-discount g: ', g
print 'State s: ', s
# Start both threads
p1 = Process(target=compute_q, args=(n, s, 'exercise'))
p2 = Process(target=compute_q, args=(n, s, 'relax'))
p1.start()
p2.start()

# Wait for threads to end
p1.join()
p2.join()

exit(0)