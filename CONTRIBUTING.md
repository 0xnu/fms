# Contributing Guidelines

I appreciate your interest in contributing to this project! I welcome your contributions and appreciate your effort to improve it.

## Getting Started

1. Fork the repository
2. Create your feature branch: `git checkout -b my-new-feature`
3. Make your changes and ensure they follow the project's coding standards
4. Compile and test your changes locally
5. Commit your changes: `git commit -s -m 'some feature'`
6. Push to the branch: `git push origin my-new-feature`
7. Create a pull request

## Building and Testing

Build and run the simulation:

```
eval $(opam env) && make clean && make all VERBOSE=1 && ./fms
```

To clean up:

```
make clean
```

## Code Style

Please follow the OCaml coding style guidelines outlined in the project. Typically for OCaml projects, this might include:

- Use 2 spaces for indentation (not tabs)
- Keep lines to a maximum of 80 characters
- Use descriptive variable and function names
- Write clear and concise comments where necessary

## Submitting Changes

- Ensure your code compiles without warnings
- Run all tests and make sure they pass
- Update documentation if you're changing functionality
- Include comments in your code where necessary
- Make sure your changes don't break existing functionality

**After your pull request is merged**, you can safely delete your branch.

## Reporting Issues

If you find a bug or have a suggestion for improvement, please open an issue on the project's issue tracker. Provide as much detail as possible, including:

- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Your environment (OCaml version, OS, etc.)

Thank you for contributing to this project!
