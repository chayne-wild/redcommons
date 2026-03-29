-- This filter intercepts the Pandoc Abstract Syntax Tree (AST) during the Quarto build.
-- It searches for Strong (bold) elements that exactly match the pattern "[p. {number}]".
-- When a match is found, it strips the bold formatting and wraps the text in a 
-- span with the class "page-number", allowing CSS to reposition it to the left margin.

function Strong(el)
  -- Check if the Strong element contains exactly one child element
  if #el.content == 1 and el.content[1].t == "Str" then
    local text = el.content[1].text
    -- Use regex to match "[p. " followed by digits and "]"
    if text:match("^%[p%.%s*%d+%]$") then
      -- Return a Span element containing the text, assigned to the 'page-number' class
      return pandoc.Span(el.content, pandoc.Attr("", {"page-number"}))
    end
  end
end
