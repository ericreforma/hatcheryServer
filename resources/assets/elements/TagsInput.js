import React, { useState, useEffect, createRef } from 'react';

const TagsInput = props => {
    const [tags, setTags] = useState(props.tags);
    const textinput = createRef();
    const [value, setValue] = useState(props.char);

    useEffect(() => {
        props.onChange(tags);
    }, [tags]);

    const removeTags = indexToRemove => {
        setTags([...tags.filter((_, index) => index !== indexToRemove)]);
    };

    const addTags = () => {
        if (value !== "" && value !== " " && value !== props.char ) {
            setTags([...tags, `${value}`]);
            setValue(props.char);
        }
    };

    const _onBlur = () => {
        addTags()
    }

    return (
        <div className={`tags-input form-control ${props.className}`} onClick={
            () => {
                textinput.current.focus();
            }
        }>
            <ul id="tags">
                {tags.map((tag, index) => (
                    <li key={index} className="tag">
                        <span className='tag-title'>{tag}</span>
                        <span className='tag-close-icon' onClick={() => removeTags(index)} >
                            x
                        </span>
                    </li>
                ))}
            </ul>
            <input
                value={value}
                type="text"
                ref={textinput}
                onKeyUp={event => (event.keyCode === 32 || event.key === 'Enter') ? addTags() : null}
                onKeyDown={ e => event.keyCode === 32 ? e.preventDefault(): null }
                onChange={ e => { setValue(e.target.value === '' ? props.char : e.target.value)}}
                onBlur={ e => _onBlur() }
            />
        </div>
    );
};

export default TagsInput;