#!/usr/bin/env python3
import random
import string

def generate_gibberish(length):
    gibberish = ''.join(random.choices(string.ascii_letters + string.digits, k=length))
    return gibberish

if __name__ == "__main__":
    terminal_width = 40  # Assuming standard terminal width
    gibberish = generate_gibberish(terminal_width * 50)  # Adjust multiplier for desired length
    print(gibberish)

