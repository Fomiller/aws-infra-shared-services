# Authentication

Local runs use AWS IAM Identity Center. CI uses GitHub OIDC. There are no
static access keys on either path.

## One-time setup

`~/.aws/config`:

```ini
[sso-session fomiller]
sso_start_url = https://d-9067a5b40d.awsapps.com/start
sso_region = us-east-1
sso_registration_scopes = sso:account:access

[profile org]
sso_session = fomiller
sso_account_id = 013683865476
sso_role_name = AdministratorAccess
region = us-east-1

[profile dev]
sso_session = fomiller
sso_account_id = 695434033664
sso_role_name = AdministratorAccess
region = us-east-1

[profile prod]
sso_session = fomiller
sso_account_id = 737133467188
sso_role_name = AdministratorAccess
region = us-east-1
```

## Every session

```bash
aws sso login --sso-session fomiller
```

One browser round trip covers all three profiles.

## Running terraform

```bash
export AWS_PROFILE=dev
export AWS_ORG_PROFILE=org
just plan route53
```

`AWS_PROFILE` is the account the stack deploys into. `AWS_ORG_PROFILE` is only
needed for units that touch the org account — `route53` owns hosted zones
there. Leave it unset in CI: the org provider then chains off the
`github-actions` role the job already assumed.
