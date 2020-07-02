import json
ls = []
for i in range(1, 10000):
    ls.append("example_input_file%i.txt" % i)
f = open("cwl.output.json", "w")
json.dump({"filelist": ls, "bigstring": "\n".join(ls)}, f)
