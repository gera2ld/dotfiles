# Best Practices

- Version Control
  - Run `jj root` to detect whether the project is managed by `jj`. If so, commit with `jj commit -m "<message>"`.
  - Always use a one-line message with no trailers.
- Package Manager
  - Check which lockfile exists (`bun.lock` or `pnpm-lock.yaml`), and use the corresponding package manager.
- TypeScript
  - Avoid type casting unless unavoidable. Prefix unused variables with `_` if they must remain.
- Comments
  - Only keep comments for code that is not self-explanatory, and only if they will still be useful a month from now.
