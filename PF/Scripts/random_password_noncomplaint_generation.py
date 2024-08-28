import string
import secrets
def random_noncomplaint_password():

    symbols = [ '^' , '{' , '}' , '[' , ']' , '(' , '.' , '<' , '>' , '"' , '!' , '?' , '%'] # Can add more
    password1 = ""
    for _ in range(9):
        password1 += secrets.choice(string.ascii_lowercase)
    password1 += secrets.choice(string.ascii_uppercase)
    password1 += secrets.choice(string.digits)
    password1 += secrets.choice(symbols)
    return (password1)