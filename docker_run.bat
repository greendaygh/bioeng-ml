docker run --rm -it -d -p 8888:8888  --name bioengml -v c:\bioengml:/home/bioengml haseong/bioengml2:tf1.14 jupyter lab --no-browser --allow-root --ip=0.0.0.0 --notebook-dir=/home/bioengml --NotebookApp.token=
