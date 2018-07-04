module ExamplesHelper

  def example_delete?(example)
    example.author?(current_user)
  end
end


