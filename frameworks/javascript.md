# JavaScript remarks

## conventions

- Functions: camelCase
- Variables: camelCase
- Constants: UPPER_SNAKE_CASE
- Files: kebab-case

## async / await

- `Event Loop`: JavaScript uses an event loop to handle asynchronous operations, which allows it to manage multiple tasks without blocking the main thread.
- `Single-Threaded`: JavaScript runs on a single thread, but the event loop and asynchronous functions enable it to perform non-blocking I/O operations efficiently.
- `Promise-Based`: JavaScript's async/await is built on top of promises. The await keyword pauses the async function until the promise resolves.
- `Execution Context`: When an async function encounters await, it returns a promise and resumes the function once the promise resolves, keeping the main thread free.
- `Concurrency`: JavaScript manages concurrency with the event loop and task queues, allowing it to handle asynchronous events without explicit multi-threading.

### Event loop workflow

- `Call Stack`: JavaScript executes code on a stack, where each function call is added to the stack and executed in order.
- `Web APIs`: Asynchronous tasks (e.g., setTimeout, fetch) are offloaded to Web APIs provided by the browser (or Node.jsin server-side JavaScript), allowing them to run independently.
- `Task Queue`: When an asynchronous operation completes, its callback is placed in the task queue.
- `Event Loop`: The event loop continuously monitors the call stack and the task queue. If the call stack is empty, it takes the first task from the queue and pushes it to the call stack for execution.

### Example 1

```js
await fetch(streetsApiUrl)
    .then(response => response.json())
    .then(data => {
        if (data.data.length > 0) {
            streetName = data.data[0].street;
        } else {
            console.log('No streets found');
        }
    })
    .catch(error => console.error('Error fetching streets', error));
```

- Adding `await` before fetch ensures that the asynchronous operation completes before moving to the next line of code in the enclosing async function.
- `await`
  - Pauses the async function until the promise resolves.
- `.then()` 
  - Handles promises resolution, doesn’t await. Returns a new promise.
  - `return` inside a then statement only returns to the former then statement, not the async fucntion around it.

### Example 2

```js
  async function fetchData() {
    const response = await fetch('https://api.example.com/data');
    const data = await response.json();
    console.log(data);
    }
fetchData();
console.log('This runs while fetch is pending');
```

- Fetch Request: fetchData() is called. await fetch(...) initiates a network request.
- Event Loop: The event loop processes other code (e.g., console.log('This runs while fetch is pending')) while the network request is handled asynchronously.
- Promise Resolution: Once the network request completes, the promise is resolved, and the event loop resumes fetchData().