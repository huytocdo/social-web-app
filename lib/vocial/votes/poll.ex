defmodule Vocial.Votes.Poll do
  use Ecto.Schema
  import Ecto.Changeset
  alias Vocial.Votes.Poll

  schema "polls" do
    field :title, :string

    has_many :options, Vocial.Votes.Option
    belongs_to :user, Vocial.Accounts.User
    has_one :image, Vocial.Votes.Image
    has_many :vote_records, Vocial.Votes.VoteRecord
    has_many :messages, Vocial.Votes.Message

    timestamps()
  end

  def changeset(%Poll{}=poll, attrs) do
    poll
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end