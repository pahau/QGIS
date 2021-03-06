/** \ingroup MapComposer
 * Attribute table item for map composer.
 */

class QgsComposerAttributeTableCompare
{
%TypeHeaderCode
#include <qgscomposerattributetable.h>
%End

  public:
    QgsComposerAttributeTableCompare();
    // bool operator()( const QgsAttributeMap& m1, const QgsAttributeMap& m2 );
    void setSortColumn( int col );
    void setAscending( bool asc );
};

/**A table class that displays a vector attribute table*/
class QgsComposerAttributeTable : QgsComposerTable
{
%TypeHeaderCode
#include <qgscomposerattributetable.h>
%End

  public:
    QgsComposerAttributeTable( QgsComposition* composition /TransferThis/ );
    ~QgsComposerAttributeTable();

    /** return correct graphics item type. Added in v1.7 */
    virtual int type() const;

    /** \brief Reimplementation of QCanvasItem::paint*/
    virtual void paint( QPainter* painter, const QStyleOptionGraphicsItem* itemStyle, QWidget* pWidget );

    bool writeXML( QDomElement& elem, QDomDocument & doc ) const;
    bool readXML( const QDomElement& itemElem, const QDomDocument& doc );

    /**Sets the vector layer from which to display feature attributes
     * @param layer Vector layer for attribute table
     * @note added in 2.3
     * @see vectorLayer
    */
    void setVectorLayer( QgsVectorLayer* layer );
    
    /*Returns the vector layer the attribute table is currently using
     * @returns attribute table's current vector layer
     * @note added in 2.3
     * @see setVectorLayer
    */  
    QgsVectorLayer* vectorLayer() const;

    /**Sets the composer map to use to limit the extent of features shown in the
     * attribute table. This setting only has an effect if setDisplayOnlyVisibleFeatures is
     * set to true. Changing the composer map forces the table to refetch features from its
     * vector layer, and may result in the table changing size to accomodate the new displayed
     * feature attributes.
     * @param map QgsComposerMap which drives the extents of the table's features
     * @note added in 2.3
     * @see composerMap
     * @see setDisplayOnlyVisibleFeatures
    */
    void setComposerMap( const QgsComposerMap* map /TransferThis/ );
    
    /*Returns the composer map whose extents are controlling the features shown in the
     * table. The extents of the map are only used if displayOnlyVisibleFeatures() is true.
     * @returns composer map controlling the attribute table
     * @note added in 2.3
     * @see setComposerMap
     * @see displayOnlyVisibleFeatures
    */  
    const QgsComposerMap* composerMap() const;

    /**Sets the maximum number of features shown by the table. Changing this setting may result
     * in the attribute table changing its size to accomodate the new number of rows, and requires
     * the table to refetch features from its vector layer.
     * @param features maximum number of features to show in the table
     * @note added in 2.3
     * @see maximumNumberOfFeatures
    */
    void setMaximumNumberOfFeatures( int features );
    
    /*Returns the maximum number of features to be shown by the table.
     * @returns maximum number of features
     * @note added in 2.3
     * @see setMaximumNumberOfFeatures
    */    
    int maximumNumberOfFeatures() const;

    /**Sets attribute table to only show features which are visible in a composer map item. Changing
     * this setting forces the table to refetch features from its vector layer, and may result in
     * the table changing size to accomodate the new displayed feature attributes.
     * @param visibleOnly set to true to show only visible features
     * @note added in 2.3
     * @see displayOnlyVisibleFeatures
     * @see setComposerMap
    */
    void setDisplayOnlyVisibleFeatures( bool b );
    
    /*Returns true if the table is set to show only features visible on a corresponding
     * composer map item.
     * @returns true if table only shows visible features
     * @note added in 2.3
     * @see composerMap
     * @see setDisplayOnlyVisibleFeatures
    */   
    bool displayOnlyVisibleFeatures() const;
    
    /*Returns true if a feature filter is active on the attribute table
     * @returns bool state of the feature filter
     * @note added in 2.3
     * @see setFilterFeatures
     * @see featureFilter
    */
    bool filterFeatures() const;
    
    /**Sets whether the feature filter is active for the attribute table. Changing
     * this setting forces the table to refetch features from its vector layer, and may result in
     * the table changing size to accomodate the new displayed feature attributes.
     * @param filter Set to true to enable the feature filter
     * @note added in 2.3
     * @see filterFeatures
     * @see setFeatureFilter
    */
    void setFilterFeatures( bool filter );

    /*Returns the current expression used to filter features for the table. The filter is only
     * active if filterFeatures() is true.
     * @returns feature filter expression
     * @note added in 2.3
     * @see setFeatureFilter
     * @see filterFeatures
    */
    QString featureFilter() const;
    
    /**Sets the expression used for filtering features in the table. The filter is only
     * active if filterFeatures() is set to true. Changing this setting forces the table
     * to refetch features from its vector layer, and may result in
     * the table changing size to accomodate the new displayed feature attributes.
     * @param expression filter to use for selecting which features to display in the table
     * @note added in 2.3
     * @see featureFilter
     * @see setFilterFeatures
    */
    void setFeatureFilter( const QString& expression );

    /*Returns the attributes fields which are shown by the table.
     * @returns a QSet of integers refering to the attributes in the vector layer
     * @see setDisplayAttributes
    */
    QSet<int> displayAttributes() const;
    
    /**Sets the attributes to display in the table.
     * @param attr QSet of integer values refering to the attributes from the vector layer to show
     * @param refresh set to true to force the table to refetch features from its vector layer
     * and immediately update the display of the table. This may result in the table changing size
     * to accomodate the new displayed feature attributes.
     * @see displayAttributes
    */    
    void setDisplayAttributes( const QSet<int>& attr );

    /*Returns the attribute field aliases, which control how fields are named in the table's
     * header row.
     * @returns a QMap of integers to strings, where the string is the field's alias.
     * @see setFieldAliasMap
    */
    QMap<int, QString> fieldAliasMap() const;
    
    /**Sets the attribute field aliases, which control how fields are named in the table's
     * header row.
     * @param map QMap of integers to strings, where the string is the alias to use for the
     * corresponding field.
     * @param refresh set to true to force the table to refetch features from its vector layer
     * and immediately update the display of the table. This may result in the table changing size
     * to accomodate the new displayed feature attributes and field aliases.
     * @see fieldAliasMap
    */    
    void setFieldAliasMap( const QMap<int, QString>& map );

    /**Adapts mMaximumNumberOfFeatures depending on the rectangle height. Calling this forces
     * the table to refetch features from its vector layer and immediately updates the display
     * of the table.
     * @see maximumNumberOfFeatures
     * @see setMaximumNumberOfFeatures
    */
    void setSceneRect( const QRectF& rectangle );

    // @note not available in python bindings
    // void setSortAttributes( const QList<QPair<int, bool> > att );

    // @note not available in python bindings
    // QList<QPair<int, bool> > sortAttributes() const;

  protected:
    virtual QMap<int, QString> getHeaderLabels() const;

  signals:
    /**This signal is emitted if the maximum number of feature changes (interactively)*/
    void maximumNumberOfFeaturesChanged( int n );
};
