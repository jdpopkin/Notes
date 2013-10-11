module RootHelper

  def recent_content(n)
    # TODO: this does not currently include albums
    # Artists Albums Songs Notes Comments. No to Votes, Users.
    big_array = Artist.includes(:user).last(n).to_a +
                Song.includes(:artist, :user).last(n).to_a +
                Note.includes(:song, :user).last(n).to_a +
                Comment.includes(:commentable, :user).last(n).to_a +
                Album.includes(:artist, :user).last(n).to_a

    big_array.sort_by! { |obj| obj.created_at }
    big_array.last(n).reverse
  end
end
