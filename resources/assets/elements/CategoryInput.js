import React, { useState, useEffect } from 'react';
import { CustomInput, Button } from 'reactstrap';

const CategoryInput = props => {
    const [categories, setCategory] = useState(props.categories);
    const [categoryList, setCategoryList] = useState(props.categoryList);
    const [toggle, setToggle] = useState(false);
    const [id, setId] = useState(props.id)
    const _handleChange = (category) => {
        if(categories.find(cat => cat.id === category.id)){
            setCategory(categories.filter(cat => cat.id !== category.id));
        } else {
            setCategory([...categories, category]);
        }
    }
    useEffect(() => {
        props.onChange(categories, id);
    }, [categories]);

    return (
        <div className={`category-input category-input-${props.type}`} onBlur={e => console.log('blurred') }>
            <ul id="categories" onClick={() => { setToggle(!toggle) }}>
                { (categories.length !== 0) ? 
                    categories.map((category, index) => (
                        <li key={index} className={`category-${props.type}`}>
                            { props.type == 'social_media' ? 
                                <div><img src={category.icon}/> {category.prettyname}</div>
                            : 
                                <span className='category-title'>{category.description}</span>
                            }
                        </li>
                    ))
                    :
                        <div>{props.placeholder}</div>
                }
            </ul>

            <div className={`category-list ${toggle ? 'category-list-active' : ''}`} >
                <div className='category-list-container'>
                    <div>

                        { props.type == 'social_media' ? 
                            categoryList.map((category, index) => 
                                <CustomInput type="checkbox" 
                                    key={index}
                                    id={`custominput_social_media_${index}`}
                                    defaultChecked={(categories.find(cat => cat.id === category.id) ? true : false)} 
                                    onClick={() => _handleChange(category) }
                                    label={<div className='category_input_image_list'>
                                        <img src={category.icon} />{category.prettyname}
                                    </div>} 
                                   
                                />
                            )
                        :
                        categoryList.map((category, index) => 
                            <CustomInput type="checkbox" 
                                key={index}
                                id={`custominput_${props.id}_${index}`}
                                defaultChecked={(categories.find(cat => cat.id === category.id) ? true : false)} 
                                onClick={() => _handleChange(category) }
                                label={category.description} 
                                
                            />
                        )}
                    </div>
                </div>
                <div className='category-done-container'>
                    <Button color="primary" onClick={e => { e.preventDefault(); setToggle(!toggle)}}>DONE</Button>
                </div>
            </div>
            
            
        </div>
    );

}

export default CategoryInput;