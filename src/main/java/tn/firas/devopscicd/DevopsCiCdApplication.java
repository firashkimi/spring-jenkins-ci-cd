package tn.firas.devopscicd;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DevopsCiCdApplication {

    public static void main(String[] args) {
        SpringApplication.run(DevopsCiCdApplication.class, args);
    }

    @GetMapping
    public String sayHello(){ return "Hello World from devops project  !";}
}
