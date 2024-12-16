# Rails error reporter test app

## Usage

This test app illustrates the difference between the development and production environments and how the errors are reported to error subscribers.

- In development, it reports the `ActionView::Template::Error` error.
- In production, it reports both the `NoMethodError` error.

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
enable_reloading: true
[#<ActionView::Template::Error: undefined method `foo' for nil>]
```

Production:

```
MyErrorSubscriber: NoMethodError: undefined method `foo' for nil
enable_reloading: false
[#<NoMethodError: undefined method `foo' for nil>]
```
