# RDFS

This repository is set up to enable you to validate Turtle files,
infer new triples based on an RDFS vocabulary, and visualize your
triples as a graph.

## Validate your Turtle files

```
make validate
```

will check that `vocab.ttl` and `description.ttl` are valid Turtle files.

## Infer new triples based on your RDFS vocabulary

```
make inferred.ttl
```

will create a file `inferred.ttl` containing the triples from
`description.ttl` plus any new triples that could be inferred based on
`vocab.ttl`. It will also create a file `diff.txt` showing the
differences bewteen `description.ttl` and `inferred.ttl`.

## Visualize any Turtle file as a graph

```
make vocab.png
```

will create a file `vocab.png` visualizing `vocab.ttl` as a
graph. This will work for any file ending in `.ttl` (for example,
`description.ttl` or `inferred.ttl`).

## Create a zip file for submitting the assignment

```
make submission.zip
```

will create a file `submission.zip`, which you can then submit here:

https://aeshin.org/teaching/assignment/218/submit/
