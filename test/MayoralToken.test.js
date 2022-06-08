const Mayoral = artifacts.require("MayoralToken");
contract("mayoral",(accounts)=>{
    let admin = accounts[0];
    let user = accounts[1];
    let user1 = accounts[2];
    it("Should set name upon construction",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.ReturnName();
        let name = "MayoralToken";
        console.log("Name is ",beta.toString());
        assert.equal(beta,name,"Name did not set upon construction");
      
    });
    it("Should set decimal upon construction",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.ReturnDecimal();
        let decimal = 1;
        console.log("Decimal is:",beta.toString());
        assert.equal(beta,decimal,"Decimal did not set upon construction");

    });
    it("Should set symbol upon construction",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.ReturnSymbol();
        let symbol = "MAYOGG";
        console.log("Symbol is :",beta.toString());
        assert.equal(beta,symbol,"Symbol did not set upon construction");

    });
    it("Should set value to mint",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.ShowTotalSupply();
        let value = 100000;
        console.log("Value to be minted is:",beta.toString());
        assert.equal(beta,value,"Sets value upon construction");
    });
    it("Should assign Total Supply to owner",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = 100000;
        const gamma = await alpha.CheckBalance(admin);
        console.log("Supply is:",beta.toString());
        console.log("Balance is:",gamma.toString());
        assert.equal(gamma,beta,"Should be equal"); 
        
    });
    it("Should deploy successfully",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.address;
        console.log("Address is:",beta.toString());
        assert(beta !== "");
    });
    it("Can Check Total Supply",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.ShowTotalSupply();
        console.log("Total Supply is:",beta.toString());
        assert.equal(beta,100000,"Supply must be equal");
    });
    it("Can Set Allowance",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.SetAllowance(user,100,{from:admin});
        const gamma = await alpha.CheckAllowance(user);
        console.log("Allowance set is :",gamma.toString());
        assert(gamma,100,"Must be Equal");
        
    });
    it("Can Increase Allowance",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.SetAllowance(user,100,{from:admin});
        const meta = await alpha.IncreaseAllowance(user,200,{from:admin});
        const gamma = await alpha.CheckAllowance(user);
        const value = 300;
        console.log("Balance after increase is :",gamma.toString());
        assert.equal(gamma,value,"Must be Equal");
    });
    it("Can Decrease Allowance",async()=>{
        const alpha = await Mayoral.deployed();
        const beta = await alpha.SetAllowance(user1,500,{from:admin});
        const metax = await alpha.DecreaseAllowance(user1,100,{from:admin});
        const gamma = await alpha.CheckAllowance(user1);
        const value = 400;
        console.log("Balance after decrease is :",gamma.toString());
        assert.equal(gamma,value,"Must be Equal");
    });
    it("Can Transfer",async()=>{
        const value = 100;
        const alpha = await Mayoral.deployed();
        const beta = await alpha.Transfer(admin,user,100);
        const gamma = await alpha.CheckBalance(user);
        console.log("Transferred value is:",gamma.toString());
        assert(gamma,value,"Must be Equal");
    });
    it("Can Check Balance",async()=>{
        const alpha = await Mayoral.deployed();
        const balance = await alpha.CheckBalance(admin);
        console.log("Check balance is:",balance.toString());
        assert("Balance after transfer is",balance,99900,"Must be Equal");
    });
    it("Can Mint",async()=>{
        const alpha = await Mayoral.deployed();
        const balanceBefore = await alpha.ShowTotalSupply();
        console.log("Balance before is : ",balanceBefore.toString());
        const beta = await alpha.Mint(admin,10000);
        const balanceAfter = await alpha.ShowTotalSupply();
        console.log("Balance After is:",balanceAfter.toString());
        assert(balanceBefore !== balanceAfter);
    });
    it("Can Burn",async()=>{
        const alpha = await Mayoral.deployed();
        const balanceBefore = await alpha.ShowTotalSupply();
        console.log("Balance before is : ",balanceBefore.toString());
        const beta = await alpha.Burn(admin,10000);
        const balanceAfter = await alpha.ShowTotalSupply();
        console.log("Balance After is:",balanceAfter.toString());
        assert(balanceBefore !== balanceAfter);
    });
    it("Can Renounce Ownership",async()=>{
        const alpha = await Mayoral.deployed();
        const OwnerBefore = await alpha.ShowOwner();
        console.log("Owner Before is :",OwnerBefore.toString());
        const renounce = await alpha.Renounce(user,{from:admin});
        const OwnerAfter = await alpha.ShowOwner();
        console.log("Owner After is :",OwnerAfter.toString());
        assert(OwnerBefore !== OwnerAfter);
    });
   




});




  
