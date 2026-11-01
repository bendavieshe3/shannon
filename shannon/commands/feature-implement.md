# /feature-implement

You MUST invoke the `work-items` skill.

Pass Type `feature`, Verb `implement`, and Target/hint from `$ARGUMENTS`. Resolve an unambiguous target from context; ask only if scope remains ambiguous.

Execute within the approved Feature or governing maintenance rule. No routine lower-level human gates apply; preserve independent technical review and escalate material divergence. Implement the Feature directly, choosing useful decomposition. Do not merely route to an Epic or require child records.

Optional execution records may retain legacy progress labels without a fixed gate sequence. Existing explicit holds and access/cost/publication permissions remain in force.

If the skill does not activate, report “Error: work-items skill failed to activate.”
