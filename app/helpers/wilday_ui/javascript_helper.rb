module WildayUi
  module JavascriptHelper
    def w_js(options = {})
      javascript_include_tag(
        "wilday_ui/index",
        {
          "data-turbo-track": "reload",
          type: "module"
        }.merge(options)
      )
    end
  end
end
