module RootHelper

  def recent_content(n)
    # Artists Albums Songs Notes Comments. No to Votes, Users.
    big_array = Artist.last(n).to_a + Song.last(n).to_a + Note.last(n) + Comment.last(n)

    big_array.sort_by! { |obj| obj.created_at }
    big_array.last(n).reverse
  end
end
