defmodule LambdaDays.TalkView do
  use LambdaDays.View
  alias LambdaDays.Router

  def title_with_score(talk) do
    talk.title <> " (score: " <> to_string(score talk) <> ")"
  end

  def votes_count(talk) do
    talk.plus_votes + talk.zero_votes + talk.minus_votes
  end

  def score(talk) do
    talk.plus_votes - talk.minus_votes
  end
end
