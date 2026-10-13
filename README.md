# Greenfield Starter

Start a project with Git, DDEV and OpenSpec. Keep product goals, users and workflows open until exploration is done.

## Create your project from this template

Template repository: [ag-constructiva/openspec-starter](https://github.com/ag-constructiva/openspec-starter).

On GitHub, select **Use this template → Create a new repository**. GitHub creates a separate repository without the template's commit history. Clone the new repository using its URL:

```sh
git clone git@github.com:YOUR-ACCOUNT/YOUR-REPOSITORY.git my-project
cd my-project
```

Run setup before the initial commit:

```sh
./setup.sh
```

The script first asks whether to create a Symfony web app. Symfony setup
requires the Symfony CLI and creates the project in this repository. It
changes the DDEV docroot to `public`. Then it asks whether to start DDEV's
database container (default: yes). Finally, it asks whether to delete
`setup.sh`. The database choice is saved in the untracked
`.ddev/config.local.yaml`; you can rerun the script later to change it if you
keep the script. It asks whether to install a minimal OpenSpec setup for Claude.
If you choose yes, it configures OpenSpec globally for skills only and the four
workflows `explore`, `propose`, `apply` and `archive`, then installs them in
this project. If you choose no, initialize OpenSpec manually later. Create the
initial commit:

```sh
git add .
git commit -m "Initialize project"
```

OpenSpec may create or update files during setup. Review the changes before committing.

Symfony is created with `symfony new <directory> --webapp`. See the
[Symfony setup guide](https://symfony.com/doc/current/setup.html) for options.

## Use an ordinary clone instead

If you cloned this repository directly instead of using GitHub's template
feature, the clone has the template's Git history. To start an independent
repository while keeping the files, remove the old Git metadata and initialize
a new repository:

```sh
rm -rf .git
git init
git add .
git commit -m "Initial project setup"
git branch -M main
git remote add origin git@github.com:YOUR-ACCOUNT/YOUR-REPOSITORY.git
git push -u origin main
```

Create the empty destination repository on GitHub first. Do not initialize it with a README, license or gitignore; this local commit will be its first commit.

## Local setup

DDEV is configured for PHP with the repository root as a temporary docroot. The setup script changes the docroot to `public` when it creates a Symfony project.

`.ddev/` and `openspec/` are versioned. DDEV's generated local files and the
machine-specific database choice are excluded by `.ddev/.gitignore`. The root
`.gitignore` excludes editor files, local environment files, dependencies and
macOS metadata.

## Start with exploration

Start your coding agent, for example:

```sh
claude
```

Then run:

```text
/opsx:explore
```

Prompt:

> Ich starte ein Greenfield-Projekt. Hilf mir zunächst, Ziele, Nutzer, Anforderungen und fachliche Abläufe zu klären. Noch keinen Code schreiben. DDEV ist für die lokale Entwicklungsumgebung gesetzt. Architektur und Stack entscheiden wir später.

Ergebnis: Git, DDEV und OpenSpec sind bereit. Die fachliche Exploration kann beginnen.
