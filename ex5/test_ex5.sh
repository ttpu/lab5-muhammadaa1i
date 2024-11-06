#!/bin/bash

# Compile the program
cd ex5
gcc -Wall -Wextra -o main main.c

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

# Run the program and capture the output
OUTPUT=$(./main)

# Check if the output matches the expected pattern
while IFS= read -r line; do
    if ! [[ $line =~ ^\'[a-z]\' [0-9]+ \'[A-Z]\' [0-9]+$ ]]; then
        echo "Output format is incorrect"
        echo "Expected format: 'a' 97 'A' 65"
        echo "Got: $line"
        exit 1
    fi
done <<< "$OUTPUT"

# Count the number of lines
line_count=$(echo "$OUTPUT" | wc -l)
if [ "$line_count" -ne 26 ]; then
    echo "Expected 26 lines of output, got $line_count lines"
    exit 1
fi

echo "Test passed!"
exit 0
