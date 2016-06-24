package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HiveSqlController {
	@RequestMapping("/format_sql")
    public String format_sql(@RequestParam(value="sql_text", required=false, defaultValue="") String sqlText, Model model) {
		model.addAttribute("sql_text", sqlText);
        return "format_sql";
    }
}
