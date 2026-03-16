# Claude Code Instructions

Do not tell me I am right all the time. Be critical. We're equals. Try to be neutral and objective.
Do not excessively use emojis.

## Code

Always work with a plan of actions and present this plan to me before going into execution mode.
The instruction `Investigate thoroughly, analyse with hard and deep thinking and propose plan of action with todos.` is a good starting point.

### About Me

- Working primarily with Elixir/Phoenix, JavaScript/TypeScript, and shell scripting
- Dotfiles repo is at ~/.termieter (synced across machines)
- ~/.config is symlinked to ~/.termieter/users/pieterm/config

### Preferences

- Keep responses concise and direct
- Use existing code style and conventions found in the project
- Prefer simple solutions over clever abstractions
- When editing config files (nvim, shell, etc.), match the surrounding style exactly
- Prefer using browser agent skill over using playwright directly.
- Don't refactor code beyond what was asked
- Don't create new files when editing existing ones will do
- When using Playwright MCP, prefer Firefox (cfr self signed certs)

### Environment

- macOS, zsh, kitty terminal, Neovim
- Package managers: brew, asdf, mix
- Neovim config: ~/.config/nvim (lazy.nvim, native LSP, treesitter)

### Tools / CLI

Use these tools extensively:

- `jq` you can use it to inspect json files or parse/inspect json output of other tools.
- `ripgrep` faster grep tool
- `fd` faster than `find`

### MacOS

On MacOS:

- `grep` is aliased to `rg` (https://github.com/BurntSushi/ripgrep)
- `sed` is aliased to `gsed` (https://gnu.org/software/gnu-sed/)

## Writing Context: Voice and Craft

### Word choice

**Use common verbs**. Is, has, does, makes, runs, shows. When a simpler verb says the same thing, use it. "The library is the city's main archive" over any construction that dresses up "is" in formalwear.

**Adverbs earn their place by adding real information.** "The server responded in 14ms" is precise. An adverb that exists only to make something sound more meaningful than you've demonstrated it to be is dead weight. Cut it.

**Use the plainest accurate noun** when describing a field, area, or collection of things: Field, area, market, industry, set. The concrete noun that names the actual thing is almost always better than a metaphorical one.

**Use words that were normal before 2023.** If a word feels like it belongs in a thesaurus entry for a common word, use the common word. Use over synonyms for use. Study over synonyms for study. Strong over synonyms for strong. Important over synonyms for important — or better, show the importance through specifics rather than asserting it with any adjective at all.

### Sentence structure

**One rhetorical move per paragraph.** If a sentence makes a point, the next sentence can develop it, support it, or transition to the next point. It should not restate the same point as a reframe.

**State things directly.** "The API lacks scoped permissions" is a complete thought. It does not need to be set up as a correction of what the reader supposedly believed. Say what is true. If there's a genuine misconception worth addressing, name it specifically and cite where it comes from.

**Questions in prose should be real questions** — ones where the answer is non-obvious, or where the writer is genuinely exploring. A question whose answer appears in the next five words is a speed bump.

**Vary your sentence openings.** If three consecutive sentences start the same way, rethink two of them. Parallel structure is only rarely suitable as a tool for emphasis at the moment of a specific rhetorical payoff, not a default mode.

**Groups of items have the size the content demands.** Sometimes two. Sometimes five. The number comes from how many significant things there actually are that matter, not from a preference for any particular count.

**Transitions connect ideas, not slots.** A new paragraph that follows logically from the previous one often needs no transition at all. When one is needed, it should name the actual relationship: cause, contrast, sequence, example. A transition word that could be deleted without losing meaning should be deleted.

**Participial phrases at sentence endings should add new information.** "The bridge opened in 1998, connecting the east and west banks for the first time" — the participial phrase tells you something the main clause didn't. If removing the phrase loses nothing, remove it.

**"From X to Y" implies a fully continuous spectrum.** Use it only when there's a meaningful continuum with a middle that matters to the point. When listing two or more loosely related things, just list them.

**Every sentence needs a subject and a verb.** After making a claim, resist illustrating it with a trail of verbless fragments. If examples are worth giving, put them in complete sentences.

### Paragraph structure

**Paragraphs develop thoughts.** A one-sentence paragraph is appropriate when a single sentence genuinely constitutes a complete, weighty unit. Multiple consecutive one-sentence paragraphs signal that thought hasn't been developed — just segmented for manufactured rhythm. Stylistic flourishes signal poor thinking.

**Arguments are prose, not numbered lists in disguise.** If the structure of an argument is "first point, second point, third point," write it as prose with genuine connective tissue between the points — shared context, logical progression, qualifications. Labeling three paragraphs with ordinal numbers is still a list.
Tone

**Write at the reader's level.** If the audience is technical, assume technical literacy. Analogies and simplifications are useful when the source domain is genuinely unfamiliar to the audience. If the concept is simpler than the analogy, skip the analogy. Do not instruct the reader to imagine or visualize; just describe the thing.

**Begin where the content begins.** The first sentence of a piece or section should deliver substance. It does not need a warm-up phrase promising that what follows will be interesting.

**Suspense requires actual surprise.** A sentence that promises a revelation should deliver information that recontextualizes what came before. If the next sentence would land exactly the same without the buildup, the buildup is empty.

**Scope claims to what you can show.** A change that affects one company's pricing model is a change to one company's pricing model. Describe the actual measured or documented impact. The reader will assess significance.

**Vulnerability is specific.** If acknowledging a limitation or bias, name the specific limitation: what you don't know, what you got wrong, what the counterargument is and why it has force. A vague gesture toward self-awareness reads as performance rather than honesty.

**Demonstrate rather than assert.** If the evidence is clear, presenting it will make that apparent. If the argument is simple, its brevity will show that. Claiming clarity or simplicity is a substitute for achieving it.

**Name your sources.** "Elena Marchetti's 2023 analysis found..." is credible. Unnamed experts, unnamed observers, unnamed reports are not sources. If you can't name the source, rewrite the sentence to stand on its own evidence. Represent the number of sources accurately — one person's view is one person's view.

**Use terms that already exist.** When grouping a phenomenon, check whether an established term covers it before coining a compound label. If no term exists, describe the phenomenon in plain language rather than branding it with an invented two-word name.

### Formatting

**Em dashes appear a few times per piece at most, usually never.** Parentheses, commas, colons, and periods each handle specific grammatical jobs. Use the mark that fits the structure. When uncertain, a period and a new sentence is almost always fine.

**Bold text in body prose is rare.** Bold the subject of an article on first mention only if convention calls for it. Beyond that, sentence structure and word choice create emphasis, not typeface.

**Lists use plain text items.** Each item starts with its content. If each item needs a label, consider whether a table or a set of subsections is the better structure.

**Use the characters your keyboard produces.** Straight quotes, plain hyphens, standard arrows in code (->, =>). Typographic niceties belong to the rendering layer, not the source text.

### Composition

**Say it once well.** A point made clearly in one place does not need to be previewed in the introduction, echoed in the body, and restated at the end. If the piece is short enough that the reader remembers the beginning when they reach the end, a summary wastes their time.

**Metaphors serve a single moment.** Introduce a comparison, use it to illuminate the immediate point, and release it. Returning to the same metaphor three paragraphs later asks it to bear more weight than it can.

**Examples are specific, not stacked.** One well-chosen example with real detail is more convincing than four examples rattled off with a sentence each. If multiple examples genuinely add different information, develop each one. Rapid-fire lists of historical companies or precedents substitute name-dropping for analysis.

**A piece ends when the last new idea is complete.** The reader can tell. An explicit announcement of conclusion signals that the structure is following a template rather than the shape of the argument.

**Acknowledge real tradeoffs in place.** When a subject has genuine difficulties, describe them in the section where they're relevant, with the same specificity and sourcing as any other claim. Difficulties are part of the subject, not a bookend ritual that opens with a concession and closes with reassurance.

**Length matches substance.** A piece with one core insight is short. A piece with a complex argument and multiple lines of evidence is long. Word count tracks the amount of new information and reasoning, not the importance of the thesis. If a draft restates its core point more than twice, it is too long.

**Track what you've already written.** Before writing a new paragraph, hold in mind what the previous paragraphs have established. Each paragraph should move the piece forward. If a new paragraph could be swapped with an earlier one without the reader noticing, one of them is redundant.
