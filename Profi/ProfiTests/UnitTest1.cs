using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using Profi.Data;
using Profi.UI.Pgs;
using System.Linq;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

// DbContext

namespace ProfiTests
{
    [TestClass]
    public class UnitTest1
    {
        
        [TestMethod]
        public void AddSAE_Test_ReturnTrue()
        {
            
            bool expected = true;
            bool actual;
            SAE sae = new SAE()
            {
                Name_SAE = "test",
                Price=123,
                Age=14,
                Result="test",
                Content="test",
                Material_Base="test",
                Count=10,
                Profi_Point=100,
                Photo_Path="test"
            };
            ProfiDBEntities2.GetContext().SAEs.Add(sae);
            try
            {
                ProfiDBEntities2.GetContext().SaveChanges();
            }
            catch (Exception ex)
            {
                Assert.Fail(ex.ToString());
            }
            var newAddedSae = ProfiDBEntities2.GetContext().SAEs.Where(x => x.Name_SAE == sae.Name_SAE);
            if (newAddedSae != null)
            {
                actual= true;
                Assert.AreEqual(expected, actual);
            }


        }
        
        [TestMethod]
        public void AddSAE_NoPrice_ReturnFalse()
        {

            bool expected = false;
            bool actual;
            SAE sae = new SAE()
            {
                Name_SAE="test1",
                Age = 14,
                Result = "test",
                Content = "test",
                Material_Base = "test",
                Count = 10,
                Profi_Point = 100,
                Photo_Path = "test"
            };
            ProfiDBEntities2.GetContext().SAEs.Add(sae);
            try
            {
                ProfiDBEntities2.GetContext().SaveChanges();
            }
            catch 
            {
                actual = false;              
                Assert.AreEqual(expected, actual);
            }
            var newAddedSae = ProfiDBEntities2.GetContext().SAEs.Where(x => x.Name_SAE == sae.Name_SAE);
            if (newAddedSae != null)
            {
                actual = true;
                Assert.AreEqual(expected, actual);
            }


        }
        
        [TestMethod]
        public void DeleteSAE_Test_ReturnTrue()
        {
            string nameToRemove = "test";
            bool expected = true;
            bool actual;           
            var newAddedSae = ProfiDBEntities2.GetContext().SAEs.Where(x => x.Name_SAE == nameToRemove).First();
       
            ProfiDBEntities2.GetContext().SAEs.Remove(newAddedSae);
            try
            {
                ProfiDBEntities2.GetContext().SaveChanges();
            }
            catch
            {
                actual = true;
                Assert.AreEqual(expected, actual);
            }

        }
        
    }
}
