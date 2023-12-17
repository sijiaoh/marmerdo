module MarkdownSupport
  def combine_into_markdown(front_matter: "", content: "")
    [
      "---",
      front_matter.to_json,
      "---",
      content
    ].join("\n")
  end
end
