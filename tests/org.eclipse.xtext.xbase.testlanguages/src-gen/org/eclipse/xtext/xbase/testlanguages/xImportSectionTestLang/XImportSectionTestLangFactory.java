/**
 */
package org.eclipse.xtext.xbase.testlanguages.xImportSectionTestLang;

import org.eclipse.emf.ecore.EFactory;

/**
 * <!-- begin-user-doc -->
 * The <b>Factory</b> for the model.
 * It provides a create method for each non-abstract class of the model.
 * <!-- end-user-doc -->
 * @see org.eclipse.xtext.xbase.testlanguages.xImportSectionTestLang.XImportSectionTestLangPackage
 * @generated
 */
public interface XImportSectionTestLangFactory extends EFactory
{
  /**
   * The singleton instance of the factory.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  XImportSectionTestLangFactory eINSTANCE = org.eclipse.xtext.xbase.testlanguages.xImportSectionTestLang.impl.XImportSectionTestLangFactoryImpl.init();

  /**
   * Returns a new object of class '<em>Import Section Test Language Root</em>'.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return a new object of class '<em>Import Section Test Language Root</em>'.
   * @generated
   */
  ImportSectionTestLanguageRoot createImportSectionTestLanguageRoot();

  /**
   * Returns the package supported by this factory.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return the package supported by this factory.
   * @generated
   */
  XImportSectionTestLangPackage getXImportSectionTestLangPackage();

} //XImportSectionTestLangFactory
