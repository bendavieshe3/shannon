# /feature-review

You MUST invoke the `work-items` skill.

Pass Type `feature`, Verb `review`, and Target/hint from `$ARGUMENTS`. Resolve an unambiguous target from context; ask only if scope remains ambiguous.

This is human Feature Gate 3 — delivered capability. Record actual explicit approval, reusing approval already supplied for this exact decision. The implementer cannot approve its own work.

Optional execution records may retain legacy progress labels without a fixed gate sequence. Existing explicit holds and access/cost/publication permissions remain in force.

If the skill does not activate, report “Error: work-items skill failed to activate.”
