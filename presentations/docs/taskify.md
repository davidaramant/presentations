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

## `TaskCompletionSource`

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
    'sequence': { 'mirrorActors': false },
    'theme': 'dark', 
    'themeVariables': { 'darkMode': true }
  }
}%%

sequenceDiagram
    participant Client
    participant WebApi
    participant Workers
    note right of Workers: There's a lot of these

    Client->>WebApi: IEnumerable<Request>
    activate WebApi

    loop For all requests
        WebApi->>Workers: Design(Request)
        activate Workers
        Workers-->>WebApi: Done(Result)
        deactivate Workers
    end

    WebApi-->>Client: ???
    deactivate WebApi
    
```
---

## Is this the correct return type?

## `Task<IEnumerable<T>>`

---

## For _batches_, return a collection

## `Task<IReadOnlyCollection<T>>`

---

## What about this?

## `IEnumerable<Task<T>>`

---

## .NET is way ahead of you

## ~~`IEnumerable<Task<T>>`~~
## `IAsyncEnumerable<T>`

---

## Different loop syntax

```csharp
IAsyncEnumerable<T> stuff = ...

await foreach(var thing in stuff)
{
    ...
}
```

---

## Also check out `System.Linq.Async`

```csharp
Select()
Where()
SingleAsync()
FirstAsync()
ToListAsync()
```

---

## Now how do we turn "function call" into `IAsyncEnumerable<T>`?

```mermaid
%%{
  init: {
    'sequence': { 'mirrorActors': false },
    'theme': 'dark', 
    'themeVariables': { 'darkMode': true }
  }
}%%

sequenceDiagram
    participant Client
    participant WebApi
    participant Workers
    note right of Workers: There's a lot of these

    Client->>WebApi: IEnumerable<Request>
    activate WebApi

    loop For all requests
        WebApi->>Workers: Design(Request)
        activate Workers
        Workers-->>WebApi: Done(Result)
        deactivate Workers
    end

    WebApi-->>Client: IAsyncEnumerable<Result>
    deactivate WebApi
    
```

---

## `System.Threading.Channels`

---

## Constructing a Channel

```csharp
private readonly Channel<TResult> _resultChannel = Channel.CreateUnbounded<TResult>(
    new UnboundedChannelOptions
    {
        SingleReader = true,
        SingleWriter = true,
        AllowSynchronousContinuations = false,
    }
);
```
---

## Return `IAsyncEnumerable`

```csharp
public IAsyncEnumerable<TResult> GetResults(CancellationToken cancellationToken) =>
    _resultChannel.Reader.ReadAllAsync(cancellationToken);
```
---

# Add stuff to the Channel

```csharp
public void HandleCompletion(TResult result)
{
    _resultChannel.Writer.TryWrite(result);
    _remainingJobs--;

    if (_remainingJobs == 0)
    {
        _resultChannel.Writer.Complete();
    }
}
```

---

# Task-ify Code
## Single thing: `TaskCompletionSource`
## Multiple things: `Channel`

---

# Questions?
