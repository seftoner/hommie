# Development Workflow Guide

This guide outlines our branching strategy, commit conventions, and development workflow.

## Branching Strategy

We follow GitHub Flow - a lightweight, branch-based workflow that centers around the `main` branch.

### Main Branch
- `main` - production-ready code that can be released at any time
- Protected branch - requires pull request reviews
- Direct commits are not allowed

### Feature Branches
- Branch from: `main`
- Merge back into: `main`
- Naming convention: `feature/ABC-123-short-description`
  - ABC-123: ticket/issue number
  - short-description: brief description using kebab-case

### Bugfix Branches
- Branch from: `main`
- Merge back into: `main`
- Naming convention: `fix/ABC-123-short-description`

### Hotfix Branches
- Branch from: `main`
- Merge back into: `main`
- Naming convention: `hotfix/ABC-123-short-description`

## Development Process

1. Create a new branch from `main`
2. Implement changes
3. Write/update tests
4. Create pull request
5. Address review comments
6. Merge to `main`

> [!IMPORTANT]
> All new features MUST be covered by tests. Pull requests without proper test coverage will not be approved.

## Commit Message Format

We follow the Conventional Commits specification:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semi-colons, etc)
- `refactor`: Code refactoring
- `test`: Adding missing tests
- `chore`: Changes to build process or auxiliary tools

### Scope
Optional scope for providing additional contextual information.

Examples:
```
feat(auth): add biometric authentication
fix(ui): correct button alignment on iOS
test(login): add integration tests for login flow
```

### Description
- Use imperative, present tense: "change" not "changed" nor "changes"
- Don't capitalize first letter
- No period (.) at the end

## Pull Request Process

1. Ensure branch is up to date with `main`
2. Write meaningful PR description
3. Link related issues
4. Add appropriate labels
5. Request reviews from team members
6. All checks must pass:
   - Tests pass
   - Code style checks pass
   - Build succeeds
   - Required reviews approved

> [!NOTE]
> Keep PRs focused and reasonably sized. Large PRs are harder to review and more likely to contain issues.
