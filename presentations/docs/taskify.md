---
title: "Task-ify C# Code"
---

# Task-ify C# Code
## David Aramant

---

## 😎

```csharp
public async Task DoStuffAsync()
{
    await Dog.WoofAsync();
    await Cat.FeedAsync();
}
```

---

## 🥵

```csharp
interface INativeApi
{
    void DoAsyncThing(int input, Action<int> callback);
}
```

---

```csharp
public Task<int> DoStuffAsync(int input)
{
    var tcs = new TaskCompletionSource<int>();

    _nativeApi.DoAsyncThing(
        input, 
        callback: i => tcs.SetResult(i));

    return tcs.Task;
}
```

---

# What about collections?

---

## JEDI Interaction with Design Workers

```mermaid
%%{
  init: {
    "flowchart": {},
    'theme': 'dark', 
    'themeVariables': { 'darkMode': true }
  }
}%%

flowchart LR
    Client

    subgraph cw [Client/WebAPI IO]
        Marks@{ shape: lean-r, label: "List{Data}" }
        WebApiResult@{ shape: lean-l, label: "???" }
    end

    WebApi

    subgraph wh [WebApi/Hangfire IO]
        Jobs@{ shape: lean-r, label: "DoWork(Job)*" }
        HangfireResult@{ shape: lean-l, label: "WorkDone(Result)*" }
    end

    Hangfire[(Hangfire)]
    Job1@{ shape: lean-r, label: "Job 2" }
    Job2@{ shape: lean-r, label: "Job 2" }
    Worker1["Worker 1"]
    Worker2["Worker N"]

    Result1@{ shape: lean-l, label: "Result 1" }
    Result2@{ shape: lean-l, label: "Result 2" }
    
    Client --> Marks --> WebApi
    WebApi --> Jobs --> Hangfire
    Hangfire --> Job1 --> Worker1
    Hangfire --> Job2 --> Worker2

    Worker1 --> Result1 --> Hangfire
    Worker2 --> Result2 --> Hangfire

    Hangfire --> HangfireResult --> WebApi --> WebApiResult --> Client
    
```
---

# Is this the correct return type?

# `Task<IEnumerable<T>>`
---

# For _batches_, return a collection

# `Task<IReadOnlyCollection<T>>`

---

# What about this?

# `IEnumerable<Task<T>>`

---

# .NET is way ahead of you

# ~~`IEnumerable<Task<T>>`~~
# `IAsyncEnumerable<T>`

---

```csharp
IAsyncEnumerable<T> stuff = ...

await foreach(var a in stuff)
{
    ...
}
```

---

# Also check out `System.Linq.Async`

```csharp
SingleAsync()
FirstAsync()
ToListAsync()
```

---

# Now how do we turn "function call" into `IAsyncEnumerable<T>`?

Diagram: updated with correct return type

---

# `System.Threading.Channels`

---

Example with channel

---

Updated diagram