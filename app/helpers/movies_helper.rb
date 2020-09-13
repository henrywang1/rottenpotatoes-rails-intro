module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
    def column_clicked?(column)
        params["clicked_header"] == column ? ["text-success", "hilite"]: nil
    end
end
