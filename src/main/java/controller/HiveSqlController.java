package controller;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import hivesql.analysis.HiveErrorListener;
import hivesql.analysis.format.BlockTool;
import hivesql.analysis.parse.HiveSQLLexer;
import hivesql.analysis.parse.HiveSQLParser;
import hivesql.analysis.parse.HiveSQLParser.StatContext;

@Controller
public class HiveSqlController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HiveSqlController.class);

	@RequestMapping("/format_sql")
	public String format_sql(@RequestParam(value = "sql_text", required = false, defaultValue = "") String sqlText,
			Model model) {
		HiveSQLLexer lexer = new HiveSQLLexer(new ANTLRInputStream(sqlText));
		HiveSQLParser parser = new HiveSQLParser(new CommonTokenStream(lexer));
		parser.addErrorListener(new HiveErrorListener(parser));
		StatContext statCtx = (StatContext) parser.stat();

		BlockTool.cutOutRedundantLines(statCtx.block);

		String formatSql=statCtx.block.show();
		LOGGER.warn("\n{}", formatSql);

		model.addAttribute("format_sql", formatSql);
		return "format_sql";
	}
}
