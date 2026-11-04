local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.inception', 'eclipse-inception') {
  settings+: {
    description: "",
    members_can_change_project_visibility: false,
    members_can_change_repo_visibility: false,
    members_can_create_teams: false,
    members_can_delete_repositories: false,
    name: "Eclipse Inception project",
    packages_containers_internal: false,
    packages_containers_public: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('eclipse-inception.github.io') {
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Website of the INCEpTION project",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      has_projects: false,
      has_wiki: false,
      homepage: "https://eclipse-inception.github.io/",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
        },
      ],
    },
    orgs.newRepo('inception') {
      allow_merge_commit: true,
      allow_rebase_merge: false,
      allow_squash_merge: false,
      dependabot_security_updates_enabled: true,
      description: "INCEpTION provides a semantic annotation platform offering intelligent annotation assistance and knowledge management.",
      has_discussions: true,
      has_wiki: false,
      homepage: "https://eclipse-inception.github.io",
      private_vulnerability_reporting_enabled: true,
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      topics+: [
        "active-learning",
        "annotation-editor",
        "annotation-suggestions",
        "annotation-tool",
        "entity-linking",
        "java",
        "knowledge-base",
        "machine-learning",
        "sparql",
        "uima"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        allow_action_patterns+: [
          "advanced-security/maven-dependency-submission-action@*",
          "stcarolas/setup-maven@*"
        ],
        allow_verified_creator_actions: false,
        allowed_actions: "selected",
      },
      webhooks: [
        orgs.newRepoWebhook('https://app.fossa.io/hooks/github/git%2Bgithub.com%2Finception-project%2Finception') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
          secret: "********",
        },
      ],
      rulesets: [
        orgs.newRepoRuleset('Main and release branch protections') {
          allows_creations: true,
          include_refs+: [
            "refs/heads/release/**/*",
            "~DEFAULT_BRANCH"
          ],
          required_pull_request+: {
            required_approving_review_count: 0,
          },
          required_status_checks+: {
            status_checks+: [
              "15368:build (ubuntu-24.04-arm, 25)"
            ],
            strict: true,
          },
        },
        orgs.newRepoRuleset('Prevent pushing local branches') {
          allows_deletions: true,
          allows_updates: false,
          include_refs+: [
            "refs/heads/local/**/*"
          ],
          required_pull_request: null,
          required_status_checks: null,
        },
      ],
      environments: [
        orgs.newEnvironment('copilot') {
        },
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/eclipsefdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}