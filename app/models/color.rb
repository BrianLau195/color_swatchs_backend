module Color
  class Base
    class << self
      def random
        raise NotImplementedError, "Subclasses must implement the `random` method"
      end

      private

      def new_color(*args)
        raise NotImplementedError, "Subclasses must implement the `new_color` method"
      end
    end
  end

  class Rgb < Base
    class << self
      def random
        new_color(*Array.new(3) { rand(256) })
      end

      private

      def new_color(r, g, b)
        { r: r, g: g, b: b }
      end
    end
  end

  class Hsl < Base
    class << self
      def random
        new_color(rand(360), *Array.new(2) { rand(101) })
      end

      private

      def new_color(h, s, l)
        { h: h, s: s, l: l }
      end
    end
  end
end
