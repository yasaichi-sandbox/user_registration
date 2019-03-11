module Web
  module Views
    module TextHelper
      # Reference: https://github.com/rails/rails/blob/5-2-stable/actionview/lib/action_view/helpers/text_helper.rb#L230
      def pluralize(count, singular, plural_arg = nil, plural: plural_arg)
        word = if (count == 1 || count.to_s =~ /^1(\.0+)?$/)
          singular
        else
          plural || Dry::Inflector.new.pluralize(singular)
        end

        "#{count || 0} #{word}"
      end
    end
  end
end
