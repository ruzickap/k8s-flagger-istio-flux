# Changelog

## [0.3.0](https://github.com/ruzickap/k8s-flagger-istio-flux/compare/v0.2.0...v0.3.0) (2024-07-02)


### Features

* **gh:** add default GitHub repo files ([#157](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/157)) ([5028012](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/5028012241c0bd49ddab1561c1594c6084fa8d08))
* **gh:** add default GitHub repo files ([#158](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/158)) ([66eb1d2](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/66eb1d22eacc3a7b9284525d993c56d811f4aff7))
* **gha:** update gha + add ignore-unfixed to trivy ([#174](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/174)) ([a8cec8b](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/a8cec8b11e65dc28343fe9afb566de776339b957))


### Bug Fixes

* add CVE-2024-4068 to .trivyignore.yaml ([#182](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/182)) ([b59c143](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/b59c143ab63831413ae0f98f4de07c9147318b03))
* **doc:** fix k8s logo url ([#175](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/175)) ([99ea157](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/99ea15751f5a769bf9f2c3e146aebe3a466b0a00))
* **renovate:** skip terraform updates ([#154](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/154)) ([88eadfa](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/88eadfaf47869ba451ff5bc3788d0f80396e1ecb))
* **tekton:** fix tekton configuration ([#156](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/156)) ([12a12d7](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/12a12d7f845a98a6f8bb70fb75b920dcd16ad037))
* **url:** exclude package-lock.json from URL checks ([#179](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/179)) ([b3f05dd](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/b3f05dda21efbb7b78b7602dba96dbb18f91af89))

## [0.2.0](https://github.com/ruzickap/k8s-flagger-istio-flux/compare/v0.1.1...v0.2.0) (2024-02-04)


### Features

* **gha:** unify GHA - renovate, megalinter, markdown, and others ([#141](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/141)) ([290b068](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/290b068c46132cd050e60d63a7fd7e53f76dbc8e))


### Bug Fixes

* **build:** fix link check in build process ([#152](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/152)) ([9702418](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/97024187c1cdb829a00251ef9615246930bbcdf1))
* **tf:** terraform upgrade ([#150](https://github.com/ruzickap/k8s-flagger-istio-flux/issues/150)) ([9eb9068](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/9eb906855228619973cd445eb3441e1728f9ebff))

## [v0.1.1](https://github.com/ruzickap/k8s-flagger-istio-flux/compare/v0.1.0...v0.1.1) (2021-12-20)

- Improve GH Action files [`#92`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/92)
- Update npm [`#91`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/91)
- Fix linter issues [`#90`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/90)
- Use new terraform syntax [`#89`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/89)
- Upgrade GH Actions versions [`#88`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/88)
- npm update [`#87`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/87)
- Upgrade action-my-broken-link-checker [`#76`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/76)
- Fix My Broken Link Checker parameter [`#66`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/66)
- Update package-lock.json [`#65`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/65)

## [v0.1.0](https://github.com/ruzickap/k8s-flagger-istio-flux/compare/v0.0.1...v0.1.0) (2020-09-17)

- Add actions/checkout with gh-pages to periodic-broken-link-checks.yml [`#63`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/63)
- Remove checkout action from periodic-broken-link-checks [`#53`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/53)
- Replace markdown linter [`#50`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/50)
- Add super-linter [`#45`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/45)
- Fix GH variables to pass the tests [`#44`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/44)
- Move to GitHub's Dependabot [`#33`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/33)
- Use shell-linter in latest version [`#32`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/32)
- Bump @vuepress/plugin-back-to-top from 1.4.1 to 1.5.0 [`#27`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/27)
- Bump @vuepress/plugin-medium-zoom from 1.4.1 to 1.5.0 [`#29`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/29)
- Bump vuepress from 1.4.1 to 1.5.0 [`#28`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/28)
- Fix markdown check [`#30`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/30)
- Fix Terraform formatting [`#26`](https://github.com/ruzickap/k8s-flagger-istio-flux/pull/26)

## v0.0.1 (2020-05-11)

- Fix terrafrom - pin versions [`6bbb7a8`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/6bbb7a8bcd1df530510cb995594f60e974ac3d4b)
- Add shellcheck [`05842bd`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/05842bd6b62f5111c979c495a8e8ffb0b838845a)
- Improve all shell scripts to pass shellcheck [`2184896`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/2184896b311ccc0d4c1d49f2baa24bc767d59858)
- Add .pre-commit-config.yaml and .release-it.yml to .gitignore [`21a5159`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/21a51599de47869992abd30e79928f8abb76cd26)
- Fix terraform formatting [`b83c0b4`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/b83c0b427b0b0cd8d3ec5f1e28c8dc4e4c0ef517)
- Update ubuntu from ubuntu-18.04 -&gt; ubuntu-latest [`b24b755`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/b24b755d66c76de4c0d770381b62f78b8ad7fa1e)
- Fix fluxctl URL [`f3dd0a0`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/f3dd0a0689f103fc7baf1d39a8e8eab34586ba44)
- Fix broken link [`d8da6fa`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/d8da6fa1f9820df0af454f5877b692f9402353e4)
- Use action-yamllint with proper tag "v1" instead of master [`54a7930`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/54a79308a4483420f3ba62e51155f544600037b9)
- Upgrade actions-gh-pages to "v3" [`7b00822`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/7b008228915896e0ec2f6fc9192eba6ee196a115)
- Terraform updated to latest [`4b86d00`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/4b86d0045477e3de085d3a37599ee134bb1f5554)
- Add comments to .yamllint.yml [`9a54e3f`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/9a54e3fdbc4586da9fed1a964cf078c80c15c2c4)
- Add comment to .markdownlint.yml [`07ab5ec`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/07ab5ec86d2eae458660d99df3ccef2809a2ff48)
- Add comments to .gitignore [`1c26c2d`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/1c26c2d94138a3900ad8398ea3b3e551bf398237)
- Change broken link checker GH repository [`5e49644`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/5e496449ade0e78ef8a4ad04cb07f0f0730826ab)
- Periodic broken link checker improved [`8e4e9f8`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/8e4e9f804869a7fa69816c4d22535088f1ea41ff)
- Fix tests to let them run only on master branch [`9833b7c`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/9833b7c49f679c331663b51525ccb0da7e38cd63)
- GitHub Actions rewritten + necessary code fix [`1c0bb8e`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/1c0bb8e204ff72e229a0bba5276647ec3ba1f64c)
- Upgrading peaceiris/actions-gh-pages to v2.8.0 [`3e98eb3`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/3e98eb3dd468bd7ad77ca52bf1ab06448fa13844)
- Upgrading peaceiris/actions-gh-pages to v2.6.0 [`0c78a8b`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/0c78a8b76c754adbdf9e84a2d34e8b3983389c2b)
- Upgrading actions/checkout from v1 to v2 [`edf7876`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/edf7876eb0380a7694ca0f74948acabba81d1594)
- Upgrading actions/checkout from v1 to v2 [`6f6b68e`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/6f6b68e317169fb1b20a5fd5ff1ee82e4af9a907)
- Adding "Automerged updates" by Dependabot [`73bc029`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/73bc0292c2faacdfdd5e933c278eaf09bf4736c4)
- Adding "EKS GitOps challenge" URL [`a443c24`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/a443c24c8d80db1bccbde432538f6f3390d4dd3e)
- Set request limit for muffet [`96484a9`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/96484a90ad842c7c06048b48a08d3c2431da5834)
- Adding Terraform checks [`79a9965`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/79a9965a173659aa2295831a2c85d4382f1b7cea)
- Fix "Build Status" [`c569be9`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/c569be9aff4c882b37bd12ef17aaf232232cf9df)
- .nojekyll removed [`b447aab`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/b447aab88891c27e4d440820695570ed94d3442d)
- Replace GITHUB_TOKEN by ACTIONS_DEPLOY_KEY [`b6f9a2c`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/b6f9a2c2407d54929171319bd6eadb878b001f00)
- Adding GitHub Workflow instead of TravisCI [`c7dae64`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/c7dae647fdf1ad360b82633124f5315cf91225a4)
- README Requirements updated [`9fe5f11`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/9fe5f115be939f8ceaee0887b1583dd3ae39d71b)
- Fix spelchecker [`c769518`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/c769518c0a99242dfb8106e34187dba35bd417ef)
- Adding YouTube video and Asciinema [`a4d765a`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/a4d765a46438da7e96cf2ec1824c40ba15674959)
- Replace Chromium in favor of Falkon [`1b3866a`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/1b3866a51e9f45d6de2d837fee662579103d958f)
- Increasing Flux timeout [`a394391`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/a3943918bba5d2a30200b61a2a3f3fef50a2c788)
- Minor code fixes [`3ccaad4`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/3ccaad46bc90b624d2890b083e748101bf2469bd)
- Add LETSENCRYPT_ENVIRONMENT to clean script [`3d79ddb`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/3d79ddb145a73f688936a97cf8712f3e9e23e4b5)
- Better handling of certificates + kubed [`08dc4a0`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/08dc4a0faec2c2094287a8a71d4114d302ad9a83)
- Increase Istio version to 1.3.0 [`bb19888`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/bb198880369a73748e113156f390b44e9abdde81)
- Terraform script renamed to terraform.sh [`6a96aa3`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/6a96aa3aed1ccf5cdd81747459553c759fd598da)
- AWS terraform part described + terraform-aws-eks version increased [`5d38c20`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/5d38c20ef977ac272d0148bc671d814ab9df000e)
- Fix long lines in part-05/README.md [`cdc9460`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/cdc9460d344dbc16d6a221752f9e92af83b8aebf)
- Show variables in run-k8s-part2.sh script [`31e473d`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/31e473dbe522af3a3eae50ec7aa25a3ed6be0780)
- Useless ports removed from Istio [`2b0f06e`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/2b0f06e985d24f4d7beab9c02191199e74445f2c)
- Minor fixes [`dfbdbb9`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/dfbdbb9b7dfb957dee4aeb682148f4581cfbc1c7)
- Adding screenshots [`a84209a`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/a84209a61918ceb3a87c06a16462e9ebb53ab70c)
- Fix old titles / descriptions containing Harbor and GitLab [`4daa44e`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/4daa44e3b7ce213bbd59ef6cd8c2609d655da026)
- Fix typos [`16fef0f`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/16fef0f4df95679e72f460c1e95006831fd796e5)
- Adding "part" scripts [`f14ad79`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/f14ad797e24ce54bebfee389d194a964aaeac7e9)
- part-05 added - Canary deployment using Flagger [`f756b03`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/f756b03f8ff3f137013e493bd0c192fc07cd7d08)
- Outputs in part-04 updated [`56540fc`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/56540fc2daa7afa1e7c9c5959adcd8e97af773fe)
- Istion version increased, few Istio helm chart parameters changed [`d968aff`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/d968affeab681e68a04a8cf7a603d7458d708102)
- Add latest version of Flux and set FLUX_TIMEOUT="5m" [`e353e91`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/e353e91966f29ff0bdd25f45eb83a9a28fee7c72)
- Add fluxctl installation [`f12d08b`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/f12d08ba28323c3d6193bcf4160bb499207e866b)
- Make spell checker happy [`306cecc`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/306ceccb43c35767ece9d5d529c034f570020fc8)
- Terraform code improved + added ACR [`e723cb5`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/e723cb5fa05a9eaacdcffa4e11bf8c79c05c6264)
- Harbor removed, Tekton used for building container image [`9246e44`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/9246e447c2d2ecdba8afdf24bd0c36eadc366170)
- Adding link checker to TravisCI [`4dd9a8d`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/4dd9a8dace4a1f4fc5f013b463b3981739339455)
- Additional heading removed [`a7369aa`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/a7369aaeb16cc0d77df563c9ad26f2594355faba)
- Adding .spelling file [`5ba0259`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/5ba025969d1de9b11638cc2de704d3e3a2959076)
- Updating VuePress version to 1.1.0 [`425269b`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/425269b7f1d77036c149e03cdaac834c6cd0f5a1)
- Adding the initial version of the document [`bf40a6c`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/bf40a6c2316d4d3a1cc8878268b16d5f8e4e74e8)
- Initial commit [`f3f9511`](https://github.com/ruzickap/k8s-flagger-istio-flux/commit/f3f9511b2b2875e62ccc44bda735683d19a22627)
