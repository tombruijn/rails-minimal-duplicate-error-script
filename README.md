# Rails error reporter test app

## Usage

This test app should illustrate the difference between the development and production environments and how the errors are reported to error subscribers.

Unfortunately, I can't reproduce it exactly with this test app.

- In development, it reports the `ActionView::Template::Error` error.
- In production, it reports both the `ActionView::Template::Error` and `NoMethodError` errors.

```
# Start in development environment
ruby app.rb

# Start in production environment
RAILS_ENV=production ruby app.rb
```

## Output

Development:

```
MyErrorSubscriber: ActionView::Template::Error: undefined method `foo' for nil

[#<ActionView::Template::Error: undefined method `foo' for nil>]
```

Production:

```
MyErrorSubscriber: ActionView::Template::Error: undefined method `foo' for nil
MyErrorSubscriber: NoMethodError: undefined method `foo' for nil

[#<ActionView::Template::Error: undefined method `foo' for nil>, #<NoMethodError: undefined method `foo' for nil>]
```
