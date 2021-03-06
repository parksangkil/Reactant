# Validation

Validation classes can be used for an easy validation of for user inputs such as emails or passwords.

A good example of creating Rules for validation is in `Rules.String` class. Let's have a look at `minLenght` Rule.

```swift
public static func minLength(_ length: Int) -> Rule<String?, ValidationError> {
        return Rule { value in
            guard let value = value, value.characters.count >= length else {
                return .invalid
            }
            return nil
        }
    }
```

If the condition for valid string is not true, then this code returns `ValidationError.invalid`, otherwise returns `nil`.

Usage of this rule can look like this, when we use it as a part of `Observable` stream.

```swift
Observable.from(["this", "is", "a", "message"])
            .map { Rules.String.minLength(4).run($0) }
            .filterError()
            .subscribe(onNext: { print($0 ?? "") })
            .addDisposableTo(stateDisposeBag)
```

This code prints only `this` `message` - the strings that are valid.
