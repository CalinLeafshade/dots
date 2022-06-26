local ls = require("luasnip")
local types = require("luasnip.util.types")
local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,

	-- Crazy highlights!!
	-- #vid3
	-- ext_opts = nil,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<-", "Error" } },
			},
		},
	},
})

-- create snippet
-- s(context, nodes, condition, ...)
local snippet = ls.s

-- TODO: Write about this.
--  Useful for dynamic nodes and choice nodes
local sn = ls.sn

-- This is the simplest node.
--  Creates a new text node. Places cursor after node by default.
--  t { "this will be inserted" }
--
--  Multiple lines are by passing a table of strings.
--  t { "line 1", "line 2" }
local t = ls.text_node

-- Insert Node
--  Creates a location for the cursor to jump to.
--      Possible options to jump to are 1 - N
--      If you use 0, that's the final place to jump to.
--
--  To create placeholder text, pass it as the second argument
--      i(2, "this is placeholder text")
local i = ls.insert_node

-- Function Node
--  Takes a function that returns text
local f = ls.function_node

-- This a choice snippet. You can move through with <c-l> (in my config)
--   c(1, { t {"hello"}, t {"world"}, }),
--
-- The first argument is the jump position
-- The second argument is a table of possible nodes.
--  Note, one thing that's nice is you don't have to include
--  the jump position for nodes that normally require one (can be nil)
local c = ls.choice_node

local d = ls.dynamic_node

local snippets = {
	typescriptreact = {},
	typescript = {},
}

local function blank()
	return t({ "", "", "" })
end

local function nl()
	return t({ "", "" })
end

local function withFileName(str)
	return f(function(_, snip)
		return string.gsub(str, "{0}", snip.env.TM_FILENAME_BASE)
	end)
end

local function fromTemplate(str)
	local lines = {}
	for s in str:gmatch("([^\n]*)\n?") do
		table.insert(
			lines,
			f(function(_, snip)
				return string.gsub(s, "{0}", snip.env.TM_FILENAME_BASE)
			end)
		)
		table.insert(lines, t({ "", "" }))
	end

	return lines
end

table.insert(
	snippets.typescriptreact,
	snippet("rfc", {
		f(function(_, snip)
			return "export type " .. snip.env.TM_FILENAME_BASE .. "Props = {}"
		end, {}),
		t({ "", "", "" }),
		f(function(_, snip)
			return "export function " .. snip.env.TM_FILENAME_BASE .. "({} : " .. snip.env.TM_FILENAME_BASE .. "Props) "
		end, {}),
		t({ "{", "\treturn <div>" }),
		i(1),
		t({ "</div>", "}" }),
	})
)

table.insert(
	snippets.typescript,
	snippet("getp", {
    t("get "),
    i(1),
    t({"() {"}),
    nl(),
    t("  return this.props."),
   d(2, function(args)
			-- the returned snippetNode doesn't need a position; it's inserted
			-- "inside" the dynamicNode.
			return sn(nil, {
				-- jump-indices are local to each snippetNode, so restart at 1.
				i(1, args[1])
			})
		end,
	{1}), 
    nl(),
    t('}')
	})
)


table.insert(
	snippets.typescript,
	snippet("entid", {
		t({
			'import { Entity } from "../../../core/domain/Entity";',
			'import { UniqueEntityId } from "../../../core/domain/UniqueEntityId";',
			'import { Result } from "../../../core/logic/Result";',
		}),
		blank(),
		f(function(_, snip)
			return "export class " .. snip.env.TM_FILENAME_BASE .. " extends Entity<any> {"
		end),
		blank(),
		t({
			"  get id(): UniqueEntityId {",
			"    return this._id;",
			"  }",
			"",
			"  private constructor(id?: UniqueEntityId) {",
			"    super(null, id);",
			"  }",
			"",
		}),
		blank(),
		f(function(_, snip)
			return "  public static create(id?: UniqueEntityId): Result<" .. snip.env.TM_FILENAME_BASE .. "> {"
		end),
		nl(),
		f(function(_, snip)
			return "    return Result.ok<"
				.. snip.env.TM_FILENAME_BASE
				.. ">(new "
				.. snip.env.TM_FILENAME_BASE
				.. "(id));"
		end),
		nl(),
		t({
			"  }",
			"}",
		}),
	})
)

table.insert(
	snippets.typescript,
	snippet("vo", {
		t({
			'import { ValueObject } from "../../../core/domain/ValueObject";',
			'import { Result } from "../../../core/logic/Result";',
		}),
		blank(),
		withFileName("interface {0}Props {"),
		nl(),
		t({ "  value: string", "}" }),
		blank(),
		withFileName("export class {0} extends ValueObject<{0}Props> {"),
		nl(),
		withFileName("  private constructor(props: {0}Props) {"),
		nl(),
		t({
			"    super(props);",
			"  }",
			"",
			"  get value() {",
			"    return this.props.value;",
			"  }",
		}),
		blank(),
		withFileName("  public static create(props: {0}Props): Result<{0}> {"),
		nl(),
		f(function(_, snip)
			return "    return Result.ok(new " .. snip.env.TM_FILENAME_BASE .. "(props));"
		end),
		nl(),
		t({
			"  }",
			"}",
		}),
	})
)

table.insert(
	snippets.typescript,
	snippet("bs", {
		t({
			'import { BoundedString, validateBoundedString, } from "../../../core/domain/BoundedString";',
			'import { Result } from "../../../core/logic/Result";',
		}),
		blank(),
		withFileName("export class {0} extends BoundedString {"),
		nl(),
		blank(),
		t("  private static validator = validateBoundedString(255, true);"),
		blank(),
		withFileName("  public static create(name: string): Result<{0}> {"),
		blank(),
		withFileName('  const res = this.validator(name, "{0}");'),
		t({
			"",
			"  if (res.isFailure) {",
			"    return res;",
			"  }",
			"",
		}),
		blank(),
		withFileName("    return Result.ok(new {0}({value: name }));"),
		nl(),
		t({ "  }", "}" }),
	})
)

table.insert(
	snippets.typescript,
	snippet(
		"ent",
		fromTemplate([[
import { Entity } from "../../../core/domain/Entity";
import { UniqueEntityId } from "../../../core/domain/UniqueEntityId";
import { Result } from "../../../core/logic/Result";

interface {0}Props {}

export class {0} extends Entity<{0}Props> {
  private constructor(props: {0}Props, id?: UniqueEntityId) {
    super(props, id);
  }

  public static create(
    props: {0}Props,
    id?: UniqueEntityId
  ): Result<{0}> {
    const item = new {0}(props, id);

    return Result.ok(item);
  }
}
  ]])
	)
)

table.insert(
	snippets.typescript,
	snippet(
		"uc",
		fromTemplate([[
import { Either, left, right } from "@sweet-monads/either";
import { UseCase } from "../../../../core/domain/UseCase";
import { GenericAppError } from "../../../../core/logic/AppError";
import { Guard } from "../../../../core/logic/Guard";
import { Result } from "../../../../core/logic/Result";

type Response = Either<
  | GenericAppError.InvalidInput
  | GenericAppError.UnexpectedError
  | GenericAppError.ItemNotFound
  | Result<any>,
  Result<void>
>;

type {0}Command = {};

export class {0} implements UseCase<{0}Command, Promise<Response>> {

  constructor() {}

  async execute(request?: {0}Command): Promise<Response> {
    const guardResult = Guard.againstNullProps(request, []);

    if (!guardResult.succeeded) {
      return left(GenericAppError.InvalidInput.create(guardResult.message));
    }

    try {
      // SAVE
      return right(Result.ok());
    } catch (err) {
      return left(GenericAppError.UnexpectedError.create(err));
    }
  }
}
]])
	)
)

table.insert(
	snippets.typescript,
	snippet(
		"domenv",
		fromTemplate([[
import { IDomainEvent } from "../../../../core/domain/events/IDomainEvent";
import { UniqueEntityId } from "../../../../core/domain/UniqueEntityId";

export class {0} implements IDomainEvent {
  public readonly dateTimeOccurred: Date;
  private readonly entity : any;

  constructor(entity : any) {
    this.dateTimeOccurred = new Date();
  }

  getAggregateId(): UniqueEntityId {
    return this.entity.id;
  }
}
]])
	)
)

table.insert(snippets.typescript,
snippet("nf", {
  t("return left(GenericAppError.ItemNotFound.create());")
}))

ls.add_snippets(nil, snippets)

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
