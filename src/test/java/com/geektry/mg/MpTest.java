package com.geektry.mg;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class MpTest extends MgApplicationTests {

    @Autowired
    private MG mg;

    @Test
    public void generate() {
        mg.generate("avenger");
    }
}
