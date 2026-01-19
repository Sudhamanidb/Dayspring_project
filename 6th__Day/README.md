
📅 **Day 6 – Ruby Loops & Enumerable Methods**

---

## Ruby Loops

* **for loop**: runs for a known range; auto-increments; inclusive range with `..`
* **while loop**: runs while condition is true; requires manual initialization and increment
* **loop do**: infinite loop; requires `break` to exit
* **until loop**: opposite of while; runs while condition is false

### Loop Control Keywords

* `break` → exits the loop
* `next` → skips current iteration
* `redo` → repeats current iteration

---

## Enumerable Methods

* **select** → returns values matching the condition (non-destructive)
* **select!** → destructive version; modifies original array
* **reject** → returns values not matching the condition (non-destructive)
* **reject!** → destructive version; modifies original array
* **any?** → returns true if at least one element meets the condition
* **all?** → returns true if all elements meet the condition
* **map / collect** → return a new array based on operation
* **each** → returns original array; useful for iteration

---

## Key Learning (Day 6)

* Ruby provides multiple loop types for different needs
* Enumerable methods reduce manual looping
* Destructive methods permanently modify data
* Blocks and enumerable methods make Ruby code clean and readable

---
