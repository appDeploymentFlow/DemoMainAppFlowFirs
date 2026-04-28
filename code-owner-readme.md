# What is CODEOWNERS in GitHub
CODEOWNERS is a special file in a GitHub repository that defines who must review changes to certain files or folders.

When combined with branch protection rules, GitHub will:

✅ Automatically request reviews
✅ Require approval from specific owners
✅ Prevent merging without their approval

# Where to Create the CODEOWNERS File
GitHub only recognizes CODEOWNERS in these locations:
```
.github/CODEOWNERS   ← Recommended
docs/CODEOWNERS
CODEOWNERS (root)
```
Best practice:
```
.github/CODEOWNERS
```
# Create a CODEOWNERS File (Step-by-Step)
Step 1 — Create directory
```
mkdir -p .github
```
Step 2 — Create file
```
vi .github/CODEOWNERS
```
# CODEOWNERS File Syntax
Basic format:
```
<file_or_directory> <owner>
```
Owner can be:

GitHub username
GitHub team
Email (rare)

# Enable Branch Protection Rule (IMPORTANT)

This is where CODEOWNERS becomes enforced.
Go to:
```
GitHub Repo → Settings → Branches
```
Then:

Step-by-Step
Click Add branch protection rule
Branch name pattern:
main

(or dev, staging, etc.)

Enable:

✅ Require a pull request before merging
✅ Require approvals (choose number, e.g., 1 or 2)
✅ Require review from Code Owners ⭐ (Very Important)
✅ Require status checks (CI/CD)

Then:
Click:
Save changes

# Why This Matters (Industry Use)

Most companies use CODEOWNERS to:
🔒 Protect production code
👨‍💻 Ensure expert review
🚀 Maintain deployment quality
📦 Secure infrastructure files

Especially critical for:
Kubernetes configs
Docker files
CI/CD pipelines
Secrets handling


# How It Works (Real Flow)

Developer workflow:
```
git checkout -b feature-login
git push origin feature-login
```
Create PR → main

GitHub will:
1️⃣ Automatically request reviewers
2️⃣ Block merge
3️⃣ Wait for Code Owner approval

Until approved:
❌ Merge button disabled

After approval:
✅ Merge allowed

# Examples of CODEOWNERS file

Example 1 — Simple CODEOWNERS
```
# Default owner for everything
* @vikas-kumar

# Frontend team owns frontend folder
/frontend/ @frontend-team

# Backend team owns backend folder
/backend/ @backend-team

# DevOps owns Dockerfile
Dockerfile @devops-team
```

Example 2 — Multiple Owners
```
/backend/ @user1 @user2
```
Both users will be requested for review.

Example 3 — File Specific Owners
```
package.json @nodejs-team
nginx.conf  @devops-team
```

Example 4 - whole CI/CD workflow
```
# Default owner
* @team-leads

# Frontend React
/frontend/ @frontend-team

# Backend Node.js
/backend/ @backend-team

# Kubernetes configs
/k8s/ @devops-team

# Docker files
Dockerfile @devops-team
docker-compose.yml @devops-team

# GitHub workflows
/.github/workflows/ @devops-team
```

# Testing CODEOWNERS

To verify:
```
Create new branch
Modify file owned by someone
Create Pull Request
```
You should see:
Reviewers automatically requested

If not:
Check:
File location
Username spelling
Team permissions

# Advanced CODEOWNERS Patterns

You can use patterns like:
```
# All YAML files
*.yaml @devops-team

# All scripts
/scripts/*.sh @devops-team

# Only production configs
/config/prod/ @senior-devops

# Multiple teams
/backend/ @backend-team @qa-team

# Specific files
Dockerfile @devops-team
docker-compose.yml @devops-team
```

# What Does - @groupname Mean in CODEOWNERS?
The - (minus) removes or overrides ownership inherited from earlier rules.
It is used when:
✅ You want to exclude a group
✅ You want to override previous ownership
✅ You want to fine-tune access inside folders
Think of it like:
"Remove this owner from this specific path."

Example-1 Default Owner, But Remove for Specific Folder
```
# Default owner for everything
* @dev-team

# Remove dev-team ownership for docs
/docs/ -@dev-team @docs-team
What happens:
Path	Required Reviewers
/app.js	@dev-team
/docs/readme.md	@docs-team (dev-team removed)
```

Example — Override Folder Ownership
```
* @engineering-team

/frontend/ @frontend-team
/backend/  @backend-team

# Remove frontend team from shared configs
/shared/ -@frontend-team @backend-team
```
- Meaning:
/frontend/ → frontend-team
/backend/ → backend-team
/shared/ → backend-team only (frontend removed)

Example — Real DevOps Repo (Your Use Case)
```
Typical structure:

repo/
├── frontend/
├── backend/
├── k8s/
├── docker/
├── scripts/
└── docs/
```
CODEOWNERS:
```
# Default reviewers
* @dev-team

# Specific ownership
/frontend/ @frontend-team
/backend/  @backend-team

# DevOps owns infra
/k8s/      @devops-team
/docker/   @devops-team

# Remove dev-team from infra
/k8s/      -@dev-team @devops-team
/docker/   -@dev-team @devops-team

# Docs team owns documentation
/docs/     -@dev-team @docs-team
```

Example — Nested Folder Override
```
/backend/ @backend-team

# Special subfolder
/backend/payment/ @payment-team

# Remove backend-team from payment
/backend/payment/ -@backend-team @payment-team
```
- Result:
Path	Reviewers
/backend/api.js	backend-team
/backend/payment/pay.js	payment-team

Example — File-Level Exclusion
```
# Default team
* @dev-team

# Special config file
config/prod.yaml -@dev-team @senior-devops
```
- Meaning:
Only senior-devops reviews production config.
Very useful for:
🔐 production configs
🔐 secrets handling
🔐 deployment pipelines

Example — Multiple Teams + Removal
```
# Default owners
* @dev-team @qa-team

# Frontend rules
/frontend/ @frontend-team

# Remove QA from frontend
/frontend/ -@qa-team @frontend-team
```
- Result:
Path	Reviewers
/frontend/app.js	frontend-team
/backend/api.js	dev-team + qa-team

## Very important in DevOps:
```
# Default
* @dev-team

# Workflows must be reviewed by DevOps only
/.github/workflows/ -@dev-team @devops-team
```
Prevents:
🚫 accidental CI/CD changes
🚫 unauthorized workflow edits

# Rule Order Matters (Very Important)

CODEOWNERS is read top to bottom.
Last matching rule wins.
Example:
```
* @dev-team

/backend/ @backend-team

/backend/payment/ -@backend-team @payment-team
```
- Result:
/backend/api.js → backend-team
/backend/payment/pay.js → payment-team

- Common Real-World Pattern
- Used in large teams:
```
# Default reviewers
* @engineering

# Frontend
/frontend/ @frontend

# Backend
/backend/ @backend

# DevOps
/k8s/     @devops
/docker/  @devops

# Sensitive files
/secrets/ -@engineering @security-team

# CI/CD
/.github/workflows/ -@engineering @devops
```
When Should You Use - @groupname?
Use it when:
✅ You defined default owners
✅ But want exceptions
✅ Or want strict review rules

Best scenarios:
🔐 Production configs
🚀 Deployment files
📦 Kubernetes manifests
⚙️ CI/CD workflows

# Important Warning ⚠️
Some GitHub environments do not fully support -@owner syntax depending on configuration or version behavior.

Safe alternative:

Instead of:
/docs/ -@dev-team @docs-team

Use:
/docs/ @docs-team

Because:
➡️ Last rule overrides earlier ones
This is usually enough.

### Best Practice (Industry)
Use:
Specific rule overrides default
Instead of relying heavily on -.

Example:
```
# Default
* @dev-team

# Override docs
/docs/ @docs-team

# Override infra
/k8s/ @devops-team
```
This is:
✅ Cleaner
✅ More reliable
✅ Easier to debug

Example - Practical Example for DevOps Projects
based on CI/CD, docker,Kubernetes
```
# Default team
* @engineering-team

# Frontend
/frontend/ @frontend-team

# Backend
/backend/ @backend-team

# Kubernetes
/k8s/ -@engineering-team @devops-team

# Docker
Dockerfile @devops-team
docker-compose.yml @devops-team

# GitHub Actions
/.github/workflows/ @devops-team

# Production configs
/config/prod/ @senior-devops
```
