def awesome(func):
    def wrapper() : 
        func()
        print("No, you are awesome")
    return wrapper()

@awesome
def ordinary():
    print('I am ordinary')

