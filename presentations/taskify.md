[comment]: # (This presentation was made with markdown-slides)
[comment]: # (This is a CommonMark compliant comment. It will not be included in the presentation.)
[comment]: # (Compile this presentation with the command below)
[comment]: # (mdslides presentation.md --include media)

[comment]: # (Set the theme:)
[comment]: # (THEME = moon)
[comment]: # (CODE_THEME = atom-one-dark)
[comment]: # (The list of themes is at https://revealjs.com/themes/)
[comment]: # (The list of code themes is at https://highlightjs.org/)

[comment]: # (Pass optional settings to reveal.js:)
[comment]: # (controls: true)
[comment]: # (keyboard: true)
[comment]: # (markdown: { smartypants: true })
[comment]: # (hash: false)
[comment]: # (respondToHashChanges: false)
[comment]: # (Other settings are documented at https://revealjs.com/config/)

David Aramant | March 11, 2025

# Task-ify C# Code

[comment]: # (!!!)

😎

```csharp
public async Task DoStuffAsync()
{
    await Dog.WoofAsync();
    await Cat.FeedAsync();
}
```

[comment]: # (!!!)

🥵

```csharp
interface INativeApi
{
    void DoAsyncThing(int input, Action<int> callback);
}
```

[comment]: # (!!!)

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

[comment]: # (!!!)

What about collections?

[comment]: # (!!!)

JEDI example with Hangfire

Diagram: IEnumerable<T> stuff input
Output from native: just a method call
Output from class: ?

[comment]: # (!!!)

Is this the correct return type?

```csharp
Task<IEnumerable<T>>
```

[comment]: # (!!!)

For batches, return a collection

```csharp
Task<IReadOnlyCollection<T>>
```

[comment]: # (!!!)

What about this?

```csharp
IEnumerable<Task<T>>
```

[comment]: # (!!!)

.NET is way ahead of you

```csharp
IAsyncEnumerable<T>
```

[comment]: # (!!!)

```csharp
IAsyncEnumerable<T> stuff = ...

await foreach(var a in stuff)
{
    ...
}
```

[comment]: # (!!!)

Also check out `System.Linq.Async`

```csharp
SingleAsync()
FirstAsync()
ToListAsync()
```

[comment]: # (!!!)

Now how do we turn "function call" into `IAsyncEnumerable<T>`?

Diagram: updated with correct return type

[comment]: # (!!!)

```csharp
System.Threading.Channels
```

[comment]: # (!!!)

Example with channel

[comment]: # (!!!)

Updated diagram

