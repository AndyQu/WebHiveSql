package controller;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.apache.commons.collections4.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import hivesql.analysis.HiveErrorListener;
import hivesql.analysis.format.BlockTool;
import hivesql.analysis.parse.HiveSQLLexer;
import hivesql.analysis.parse.HiveSQLParser;
import hivesql.analysis.parse.HiveSQLParser.StatContext;

@Controller
public class HiveSqlController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HiveSqlController.class);

	@RequestMapping(value="/format_sql",method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView format_sql(
			@RequestParam(value = "sql_text", required = false, defaultValue = "") String sqlText) {

		ModelAndView view = new ModelAndView("format_sql");
		view.addObject("formated_sql", sqlText);
		if (!sqlText.equals("")) {
			// Prepare
			HiveSQLLexer lexer = new HiveSQLLexer(new ANTLRInputStream(sqlText));
			HiveSQLParser parser = new HiveSQLParser(new CommonTokenStream(lexer));
			HiveErrorListener errorListener = new HiveErrorListener(parser);
			parser.addErrorListener(errorListener);
			// Parse
			StatContext statCtx = (StatContext) parser.stat();
			// Return
			view.addObject("syntax_errors", errorListener.getSyntaxErrors());
			if (CollectionUtils.isEmpty(errorListener.getSyntaxErrors())) {
				//Only when there's no syntax error, we set formated sql
				BlockTool.cutOutRedundantLines(statCtx.block);

				String formatSql = statCtx.block.show();
				LOGGER.warn("\n{}", formatSql);

				view.addObject("formated_sql", formatSql);
			}
			
		}else{
			LOGGER.warn("event_name=empty_sql_text, value={}", sqlText);
		}
		return view;
	}
}
