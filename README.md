# Kubecon NA 2026 APL Demo

## Setup
**Clone this repo:**

```bash
git clone https://github.com/akamai-developers/kubecon-na-2026-demo.git
cd kubecon-na-2026-demo
```

**Install dependencies:**
This command installs [Homebrew] if it was not already found on the system. Afterwards, run this command a second time to install the required packages.

```bash
make deps
```

**Decrypt secrets:**
Before running the demo, first manually load the `key.txt` file from an external
storage device or another source. This is the file containing the `age` secret
key used for decrypting the `.env.enc` file. Decryption is handled
automatically when executing the demo.

## Usage
Use `make` targets to interact with `run.sh`.

```bash
usage: make [args]

args:
  apps         enable more apps
  copy         copy outputs to clipboard
  clean        cleanup project artifacts
  deps         install dependencies
  destroy      teardown project
  headlamp     get headlamp token
  info         print all project outputs
  prod         setup production demo
  reset        reset project state
```

Run `create` only on the first deploy (unless for some reason you ran `destroy`
earlier). Afterwards you'll just run `reset` anytime you want to redeploy/reset
the demo to its starting point.

Args used to demonstrate features during the demo include:
- `apps`: Enables several other CNCF project apps via commit to `git` repo.
- `copy`: Runs interactive prompt for copying and pasting values into APL console
- `headlamp`: Runs `kubectl` command for retrieving headlamp service account token
- `info`: Prints all current outputs (URLs, usernames, passwords, etc) to the terminal
- `prod`: Creates simulated dev teams and adds additional manifests for headlamp 

APL has received a good amount of light on its benefits from a Platform Engineer's perspective, so it would be good if this demo can also open the perspective from a tenant―a non-admin developer on a team which uses the platform for cloud native application development. Ultimately you should let conversation lead the demo, as well as the _"why"_ App Platform. Until that happens however, you can use the steps below to guide the direction of both demo and conversation.

### Reset
Always start with a clean slate. Ideally this should be done already _before_ doing the demo again for the next person.

```bash
make reset
...
[ info ] reset repo ✔️
[ info ] delete local branch ✔️
[ info ] delete remote branch ✔️
[ info ] clean up state ✔️
[ info ] delete lke cluster ✔️
[ info ] purging obj buckets ✔️
[ info ] delete lke692447-cnpg ✔️
[ info ] delete lke692447-gitea ✔️
[ info ] delete lke692447-harbor ✔️
[ info ] delete lke692447-kubeflow-pipelines ✔️
[ info ] delete lke692447-loki ✔️
[ info ] purging volumes ✔️
[ info ] deploy lke cluster ✔️
[ info ] provisioning nodes (ready|ready|ready) ✔️
[ info ] node pool is ready ✔️
[ info ] fetching kubeconfig ✔️
[ info ] download kubeconfig ✔️
[ info ] installing app platform ✔️
[ info ] apl is ready ✔️
[ info ] fetch console url ✔️
[ info ] fetch username ✔️
[ info ] fetch password ✔️

welcome to app platform
-----------------------
 apl:consoleUrl    https://console.lke693956.akamai-apl.net
 apl:username      platform-admin@lke693956.akamai-apl.net
 apl:initPassword  !xTM4Q2rVPr!1zz78CTW
 apl:password      [redacted]
```

### Apps
To demonstrate enabling seveal of the available CNCF projects via gitops, run `make apps` and answer `y` to the input prompt to push the `git` commit.

```bash
make apps
...
[ info ] From https://github.com/akamai-developers-bot/apl-values
 * branch            main       -> FETCH_HEAD
Already up to date.

[ info ] Fetching origin
From https://github.com/akamai-developers-bot/apl-values
 * [new branch]      kubecon-1  -> origin/kubecon-1

[ info ] Switched to a new branch 'kubecon-1'
Branch 'kubecon-1' set up to track remote branch 'kubecon-1' from 'origin'.

[ info ] From https://github.com/akamai-developers-bot/apl-values
 * branch            kubecon-1  -> FETCH_HEAD
Already up to date.

[ input ] commit changes? (y/n) y

[ info ] [kubecon-1 7277150] enable apps with git
 9 files changed, 15 insertions(+), 15 deletions(-)

[ info ] To https://github.com/akamai-developers-bot/apl-values.git
   ce8e49c..7277150  kubecon-1 -> kubecon-1
Branch 'kubecon-1' set up to track remote branch 'kubecon-1' from 'origin'.
```

### Copy
Run `make copy` and select a number for value (individual secrets) or group of values (group vars) that you want to copy outputs to clipboard for pasting. This is purely to reduce the amount of time spent on repetitively, manually typing inputs.

For example, to perform the initial login to APL console after a `make reset`, run `make copy` and then select the number representing `apl` from the menu. In the snippet below, `4` is the number for `apl`. Follow the prompts and copy/paste outputs to the APL console in a browser tab.

If for example, we only needed the Linode APi token, we'd select `2`. You'll see `copied to clipboard ✔️` to indicate when an output has been successfully copied.

```bash
make copy
...
secrets
-------
    1:       apl:password
    2:       linode:token
    3:       repo:password

group vars
----------
    4:       apl
    5:       catalog
    6:       repo

[ input ] select value(s) to copy (int): 4

[ input ] copy apl:consoleUrl (y/n): y
[ info ] copied to clipboard ✔️

[ input ] copy apl:username (y/n): y
[ info ] copied to clipboard ✔️

[ input ] copy apl:initPassword (y/n): y
[ info ] copied to clipboard ✔️

[ input ] copy apl:password (y/n): y
[ info ] copied to clipboard ✔️
```

### Headlamp
After running `make prod`, you can run `make headlamp` to generate or retrieve the `headlamp-admin` [service account token](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/#tokenrequest-api). The `make copy` menu will now also display a `headlamp` section to copy the token value for logging into the Headlamp web UI.

```bash
make headlamp
...
[ info ] headlamp service account token ✔️

headlamp
--------
 headlamp:url   https://headlamp.lke693956.akamai-apl.net
 headlamp:token [redacted]
```

```bash
make copy
...
secrets
-------
    1:       apl:password
    2:       linode:token
    3:       repo:password
    4:       headlamp:token

group vars
----------
    5:       apl
    6:       catalog
    7:       repo
    8:       headlamp

[ input ] select value(s) to copy (int):
```

### Info
Run `make info` to print all available outputs to the terminal. The snippet below demonstrates the initial `info` output after a fresh `make reset`. 

```bash
make info
...
[ info ] fetch console url ✔️
[ info ] fetch username ✔️
[ info ] fetch password ✔️

welcome to app platform
-----------------------
 apl:consoleUrl    https://console.lke693956.akamai-apl.net
 apl:username      platform-admin@lke693956.akamai-apl.net
 apl:initPassword  !xTM4Q2rVPr!1zz78CTW
 apl:password      [redacted]

byo catalog
-----------
 catalog:url   https://github.com/GoogleCloudPlatform/microservices-demo.git
 catalog:name  google-msv
 catalog:name  main

repo info
---------
 repo:url       https://github.com/akamai-developers-bot/apl-values
 repo:password  [redacted]
 repo:email     devrel@akamai.com
 repo:branch    kubecon-1
```

Additional outputs become available (i.e. after running `make prod`) as soon as they're created.

```bash
make info
...
headlamp
--------
 headlamp:url   https://headlamp.lke693956.akamai-apl.net
 headlamp:token [redacted]

manifests
---------
 manifest:argocd-headlamp.yaml  env/manifests/namespaces/argocd/applications
 manifest:gateway-headlamp.yaml env/manifests/namespaces/headlamp/httproute
```

### Prod

After adding the new microservices application catalog (`make copy` and then select number for `catalog`), to better demonstrate a production setup with multiple development teams―each responsible for a single micro service―you can run `make prod` to push a `git` commit for adding these teams to the values repo. After waiting a few seconds, you can refresh the `Teams` page in the APL console to see them. This commit also quietly adds the custom manifests for `headlamp`.

```bash
make prod
...
[ info ] From https://github.com/akamai-developers-bot/apl-values
 * branch            main       -> FETCH_HEAD

[ info ] From https://github.com/akamai-developers-bot/apl-values
 * branch            kubecon-1  -> FETCH_HEAD

[ info ] [kubecon-1 8c8cfe1] add prod demo teams and manifests
 139 files changed, 2298 insertions(+)
 create mode 100644 env/manifests/namespaces/argocd/applications/argocd-headlamp.yaml
 create mode 100644 env/manifests/namespaces/headlamp/httproute/gateway-headlamp.yaml
 create mode 100644 env/teams/ads/builds/adservice-main.yaml
 create mode 100644 env/teams/ads/builds/adservice-v1.yaml
 create mode 100644 env/teams/ads/builds/adservice-v2.yaml
 create mode 100644 env/teams/ads/codeRepos/adservice.yaml
 create mode 100644 env/teams/ads/netpols/frontend-to-ad.yaml
 create mode 100644 env/teams/ads/workloadValues/.gitkeep
 create mode 100644 env/teams/ads/workloadValues/adservice.yaml
 create mode 100644 env/teams/ads/workloads/adservice.yaml
 create mode 100644 env/teams/cart/builds/cartservice-main.yaml
 create mode 100644 env/teams/cart/codeRepos/cartservice.yaml
 create mode 100644 env/teams/cart/netpols/cart-to-redis.yaml
 create mode 100644 env/teams/cart/netpols/checkout-to-cart.yaml
 create mode 100644 env/teams/cart/netpols/frontend-to-cart.yaml
 create mode 100644 env/teams/cart/sealedsecrets/.gitkeep
 create mode 100644 env/teams/cart/workloadValues/.gitkeep
 create mode 100644 env/teams/cart/workloadValues/cartservice.yaml
 create mode 100644 env/teams/cart/workloadValues/redis-cart.yaml
 create mode 100644 env/teams/cart/workloads/cartservice.yaml
 create mode 100644 env/teams/cart/workloads/redis-cart.yaml
 create mode 100644 env/teams/checkout/builds/checkoutservice-main.yaml
 create mode 100644 env/teams/checkout/codeRepos/checkoutservice.yaml
 create mode 100644 env/teams/checkout/netpols/frontend-to-checkout.yaml
 create mode 100644 env/teams/checkout/workloadValues/.gitkeep
 create mode 100644 env/teams/checkout/workloadValues/checkoutservice.yaml
 create mode 100644 env/teams/checkout/workloads/checkoutservice.yaml
 create mode 100644 env/teams/currency/apps.yaml
 create mode 100644 env/teams/currency/builds/currencyservice-main.yaml
 create mode 100644 env/teams/currency/codeRepos/currencyservice.yaml
 create mode 100644 env/teams/currency/netpols/checkout-to-currency.yaml
 create mode 100644 env/teams/currency/netpols/frontend-to-currency.yaml
 create mode 100644 env/teams/currency/policies/allowed-image-repositories.yaml
 create mode 100644 env/teams/currency/policies/disallow-capabilities-strict.yaml
 create mode 100644 env/teams/currency/policies/disallow-capabilities.yaml
 create mode 100644 env/teams/currency/policies/disallow-host-namespaces.yaml
 create mode 100644 env/teams/currency/policies/disallow-host-path.yaml
 create mode 100644 env/teams/currency/policies/disallow-host-ports.yaml
 create mode 100644 env/teams/currency/policies/disallow-host-process.yaml
 create mode 100644 env/teams/currency/policies/disallow-latest-tag.yaml
 create mode 100644 env/teams/currency/policies/disallow-privilege-escalation.yaml
 create mode 100644 env/teams/currency/policies/disallow-privileged-containers.yaml
 create mode 100644 env/teams/currency/policies/disallow-proc-mount.yaml
 create mode 100644 env/teams/currency/policies/disallow-selinux.yaml
 create mode 100644 env/teams/currency/policies/require-labels.yaml
 create mode 100644 env/teams/currency/policies/require-limits.yaml
 create mode 100644 env/teams/currency/policies/require-liveness-probe.yaml
 create mode 100644 env/teams/currency/policies/require-non-root-groups.yaml
 create mode 100644 env/teams/currency/policies/require-readiness-probe.yaml
 create mode 100644 env/teams/currency/policies/require-requests.yaml
 create mode 100644 env/teams/currency/policies/require-run-as-non-root-user.yaml
 create mode 100644 env/teams/currency/policies/require-run-as-nonroot.yaml
 create mode 100644 env/teams/currency/policies/require-startup-probe.yaml
 create mode 100644 env/teams/currency/policies/restrict-apparmor-profiles.yaml
 create mode 100644 env/teams/currency/policies/restrict-seccomp-strict.yaml
 create mode 100644 env/teams/currency/policies/restrict-seccomp.yaml
 create mode 100644 env/teams/currency/policies/restrict-sysctls.yaml
 create mode 100644 env/teams/currency/policies/restrict-volume-types.yaml
 create mode 100644 env/teams/currency/sealedsecrets/.gitkeep
 create mode 100644 env/teams/currency/secrets.settings.yaml
 create mode 100644 env/teams/currency/settings.yaml
 create mode 100644 env/teams/currency/workloadValues/.gitkeep
 create mode 100644 env/teams/currency/workloadValues/currencyservice.yaml
 create mode 100644 env/teams/currency/workloads/currencyservice.yaml
 create mode 100644 env/teams/email/builds/emailservice-main.yaml
 create mode 100644 env/teams/email/codeRepos/emailservice.yaml
 create mode 100644 env/teams/email/netpols/checkout-to-email.yaml
 create mode 100644 env/teams/email/workloadValues/.gitkeep
 create mode 100644 env/teams/email/workloadValues/emailservice.yaml
 create mode 100644 env/teams/email/workloads/emailservice.yaml
 create mode 100644 env/teams/frontend/builds/frontend-main.yaml
 create mode 100644 env/teams/frontend/codeRepos/frontend.yaml
 create mode 100644 env/teams/frontend/netpols/loadgenerator-to-frontend.yaml
 create mode 100644 env/teams/frontend/services/frontend.yaml
 create mode 100644 env/teams/frontend/workloadValues/.gitkeep
 create mode 100644 env/teams/frontend/workloadValues/frontend.yaml
 create mode 100644 env/teams/frontend/workloads/frontend.yaml
 create mode 100644 env/teams/loadgen/builds/loadgen-main.yaml
 create mode 100644 env/teams/loadgen/codeRepos/loadgen.yaml
 create mode 100644 env/teams/loadgen/workloadValues/.gitkeep
 create mode 100644 env/teams/loadgen/workloadValues/loadgen.yaml
 create mode 100644 env/teams/loadgen/workloads/loadgen.yaml
 create mode 100644 env/teams/payment/builds/paymentservice-main.yaml
 create mode 100644 env/teams/payment/codeRepos/paymentservice.yaml
 create mode 100644 env/teams/payment/netpols/checkout-to-payment.yaml
 create mode 100644 env/teams/payment/workloadValues/.gitkeep
 create mode 100644 env/teams/payment/workloadValues/paymentservice.yaml
 create mode 100644 env/teams/payment/workloads/paymentservice.yaml
 create mode 100644 env/teams/prodcatalog/apps.yaml
 create mode 100644 env/teams/prodcatalog/builds/prodcatalogservice-main.yaml
 create mode 100644 env/teams/prodcatalog/codeRepos/prodcatalogservice.yaml
 create mode 100644 env/teams/prodcatalog/netpols/checkout-to-prodcatalog.yaml
 create mode 100644 env/teams/prodcatalog/netpols/frontend-to-prodcatalog.yaml
 create mode 100644 env/teams/prodcatalog/netpols/recommend-to-prodcatalog.yaml
 create mode 100644 env/teams/prodcatalog/policies/allowed-image-repositories.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-capabilities-strict.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-capabilities.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-host-namespaces.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-host-path.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-host-ports.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-host-process.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-latest-tag.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-privilege-escalation.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-privileged-containers.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-proc-mount.yaml
 create mode 100644 env/teams/prodcatalog/policies/disallow-selinux.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-labels.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-limits.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-liveness-probe.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-non-root-groups.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-readiness-probe.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-requests.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-run-as-non-root-user.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-run-as-nonroot.yaml
 create mode 100644 env/teams/prodcatalog/policies/require-startup-probe.yaml
 create mode 100644 env/teams/prodcatalog/policies/restrict-apparmor-profiles.yaml
 create mode 100644 env/teams/prodcatalog/policies/restrict-seccomp-strict.yaml
 create mode 100644 env/teams/prodcatalog/policies/restrict-seccomp.yaml
 create mode 100644 env/teams/prodcatalog/policies/restrict-sysctls.yaml
 create mode 100644 env/teams/prodcatalog/policies/restrict-volume-types.yaml
 create mode 100644 env/teams/prodcatalog/sealedsecrets/.gitkeep
 create mode 100644 env/teams/prodcatalog/secrets.settings.yaml
 create mode 100644 env/teams/prodcatalog/settings.yaml
 create mode 100644 env/teams/prodcatalog/workloadValues/.gitkeep
 create mode 100644 env/teams/prodcatalog/workloadValues/prodcatalogservice.yaml
 create mode 100644 env/teams/prodcatalog/workloads/prodcatalogservice.yaml
 create mode 100644 env/teams/recommend/builds/recommendationservice-main.yaml
 create mode 100644 env/teams/recommend/codeRepos/recommendationservice.yaml
 create mode 100644 env/teams/recommend/netpols/frontend-to-recommendation.yaml
 create mode 100644 env/teams/recommend/workloadValues/.gitkeep
 create mode 100644 env/teams/recommend/workloadValues/recommendationservice.yaml
 create mode 100644 env/teams/recommend/workloads/recommendationservice.yaml
 create mode 100644 env/teams/shipping/builds/shippingservice-main.yaml
 create mode 100644 env/teams/shipping/codeRepos/shippingservice.yaml
 create mode 100644 env/teams/shipping/netpols/checkout-to-shipping.yaml
 create mode 100644 env/teams/shipping/netpols/frontend-to-shipping.yaml
 create mode 100644 env/teams/shipping/workloadValues/.gitkeep
 create mode 100644 env/teams/shipping/workloadValues/shippingservice.yaml
 create mode 100644 env/teams/shipping/workloads/shippingservice.yaml

[ info ] To https://github.com/akamai-developers-bot/apl-values.git
   3be6ec8..8c8cfe1  kubecon-1 -> kubecon-1
Branch 'kubecon-1' set up to track remote branch 'kubecon-1' from 'origin'.
```