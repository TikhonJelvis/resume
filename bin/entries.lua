-- Geneated \dated subsections for headers start/end properties

local List = pandoc.List

-- split a list of Inlines by Str "|"
function split(inlines)
   local parts = List:new{List:new{}}
   local i = 1
   for _, e in ipairs(inlines) do
      if e == pandoc.Str("|") and i < 4 then
         i = i + 1
         parts[i] = List:new{}
      else
         parts[i]:extend(List:new{e})
      end
   end

   return parts
end

-- align up to 3 parts of a line separated by | into left, center and
-- right spans
--
-- returns a left, center and right span if there are two or more |s
--
-- returns a left and right span if there is one |
--
-- returns the inline elements unchanges if there are no |s
function aligned_spans(inlines)
   local parts = split(inlines)

   if #parts == 2 then
      return {
         pandoc.RawInline('latex', '\\lr{'),
         pandoc.Span(parts[1]),
         pandoc.RawInline('latex', '}{'),
         pandoc.Span(parts[2]),
         pandoc.RawInline('latex', '}')
      }
   elseif #parts == 3 then
      return {
         pandoc.RawInline('latex', '\\lcr{'),
         pandoc.Span(parts[1]),
         pandoc.RawInline('latex', '}{'),
         pandoc.Span(parts[2]),
         pandoc.RawInline('latex', '}{'),
         pandoc.Span(parts[3]),
         pandoc.RawInline('latex', '}')
      }   
   else
      return inlines
   end
end

-- Special formatting for headers that contain |
--
-- Lets me write stuff like
--
-- ## Software Engineer | Esper | Jul 2014–Oct 2015
function Header(block)
   if FORMAT:match 'latex' then
      return pandoc.Header(block.level, aligned_spans(block.content), block.attr)
   end
end


-- Special formatting for list items that contain a |
--
-- This lets me write stuff like
--
--  * Organizer | Haskell.org, inc | 2018–now
function BulletList(block)
   if FORMAT:match 'latex' then
      return pandoc.walk_block(block, {
            Plain = function (e)
               return pandoc.Plain(aligned_spans(e.content))
            end
      })
   end
end
