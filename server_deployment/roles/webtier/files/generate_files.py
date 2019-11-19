import random
import string

number_of_files=random.choice(range(9,100))
path="/usr/share/nginx/html/new_log_dir1/"

for i in range(0,number_of_files):
        with open(path+random.choice(string.ascii_lowercase)+str(i)+".log","w") as f:
                f.write("dummy log line"+str(i))