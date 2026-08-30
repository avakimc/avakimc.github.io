---
org: Acorn Investment Partners
orgNote: A portfolio company of Oaktree Capital Management, L.P.
role: Artificial Intelligence Intern
location: Greenwich, CT
dates: May – August 2026
order: 1
tags: []
links: []
---

Developed three automated programs to improve the firm's efficiency and accuracy by
reducing manual workload. Each went from a manual process or single-user prototype to
unattended operation on a dedicated server. I also supported the firm's Head of Trading
with BDC analysis and new-issue strategy development.

### P&L Reporting

Replaced a manual Excel process with an automated Python platform — roughly 20,000 lines
of code with an 871-test pytest suite, built in about eight weeks. It raised reporting
frequency from weekly to daily, providing the Head of Trading with end-of-day P&L
summaries after market close, and increased accuracy by accounting for in-period trades,
accruals, dividend date drops, and more.

The pipeline pulls market data through the Bloomberg Terminal API, firm-specific
accounting data via Playwright browser automation of the accounting portal, and publishes
both Excel and PDF versions of the reports through Microsoft Graph to SharePoint and
email. Each reporting cadence (daily, weekly, monthly) fires unattended via Windows Task
Scheduler.

Before my departure, I documented the methodology behind each type of holding's specific
P&L calculation: day-count accrual conventions with coupon proration, wrapped-debt
mark-to-market, TIPS inflation-adjusted principal, T-bill discount-rate pricing, and
multi-currency curve interpolation.

Reports are rendered with openpyxl and were reconciled cell-exact against the incumbent
human-produced ones.

A no-code configuration layer — Excel workbooks validated by a Python script — allows the
Head of Trading to update firm and holding-specific information without touching code.

<p class="stack">Python · Bloomberg (blpapi / xbbg) · Playwright · openpyxl · Microsoft Graph · Windows Task Scheduler · pytest · pandas</p>

### Synthesize — Autonomous Morning-Briefing Service

Took an email-synthesis prototype to a multi-user production service in four weeks: ~6,200
lines of code. Each morning it fetches every registered user's Outlook mail, calendar,
SharePoint notes, and Granola meeting transcripts through Microsoft Graph and Granola API,
synthesizes the collected information, and develops a personalized morning brief via the
Claude API. Morning briefs include itemized Action Items, tasks "Waiting on Me", and tasks
"Waiting on Others", delivered by email and Slack DM through Microsoft Graph and the Slack
API.

Users can reply to emails/DMs in plain English to mark action items complete, add tasks
for the next morning's brief, or set standing memories that persist across every future
run.

Re-architecting the pipeline from an agentic tool-using loop to a single direct API call
cut per-run cost by 59% and structurally eliminated prompt-injection risk — email content
only shapes a morning brief's text; it never triggers any AI-performed actions on behalf
of the user.

Model and feature decisions went through a blind A/B harness with pre-registered decision
rules, optimizing for accuracy while keeping cost low. The 426-test suite runs entirely
offline with no credentials.

The codebase, and what came out of building it, is now the foundation for the firm's next
project: an in-house CRM.

<p class="stack">Python · Claude API · Microsoft Graph · Slack API · LLMs · pytest</p>

### Daily Digest — AI-Powered Financial News Digest

Refactored one person's morning news brief into an unattended service for the team,
growing the test suite from zero to 502 tests. It ingests newspapers, SEC EDGAR filings,
FRED macro series, iShares, Yahoo Finance, and Substack publications, and uses the Claude
API to synthesize a morning digest delivered via the Gmail API.

Each user gets digest variants matching their own subscriptions, with a weekly summary
every Friday. An email-reply Q&A bot backed by retrieval-augmented generation —
sentence-transformers embeddings searched through FAISS — lets them follow up on anything
in that morning's digest, and the refactor allows users to configure personalized alerts
on specific tickers or on broader market conditions.

I redesigned the cross-run memory layer from wholesale daily rewrites into incremental
per-story timelines: 64% cheaper per update and immune to the silent story-dropping the
original design was doing. Ingestion was parallelized 3×, and reusing stored embeddings
cut full-day re-indexing from 245s to 36s. Per-call cost accounting and prompt-cache
sharing hold the whole system to roughly $50/month for the firm.

<p class="stack">Python · Claude API · Gmail API · RAG · sentence-transformers · FAISS · SEC EDGAR · FRED · pytest</p>
