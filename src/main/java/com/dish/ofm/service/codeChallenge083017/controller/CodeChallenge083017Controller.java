package com.dish.ofm.service.codeChallenge083017.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CodeChallenge083017Controller {

    private static Logger LOGGER = LoggerFactory.getLogger(CodeChallenge083017Controller.class);

    @RequestMapping(value = "/challenge", method = RequestMethod.GET, produces = "application/json")
    @ApiOperation(value = "challenge", httpMethod = "GET",
        response = HttpStatus.class,
        produces = "application/json")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "challange 803017", response = HttpStatus.class),
        @ApiResponse(code = 500, message = "Internal server error")})
    public ResponseEntity challenge() {
        LOGGER.info("Received /challenge");

        ResponseEntity<Void> responseEntity = ResponseEntity.ok().build();

        LOGGER.info("Finished /challenge with  responseEntity = {}", responseEntity);
        return responseEntity;
    }
}
